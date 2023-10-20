-- @block Consolidating all infrastructure
CREATE OR REPLACE TABLE `$project.$dataset.paris_bike_all_infrastructure`
CLUSTER BY (geom)
AS (
  WITH
    infra_cte AS (
      SELECT geometry AS geom, length, typologie_s
      FROM `cartobq.docs.paris_cyclable_routes`
    ),
    weight_cte AS (
      SELECT
        geom,
        typologie_s,
        length,
        CASE
          WHEN typologie_s = 'Couloirs de bus ouverts aux vélos' THEN 0.25
          WHEN typologie_s = 'Bandes cyclables' THEN 0.5
          WHEN typologie_s = 'Autres itinéraires cyclables (ex : Aires piétonnes - Contre-sens cyclables)' THEN 0.75
          WHEN typologie_s = 'Pistes cyclables' THEN 1
        END AS weight
      FROM
        infra_cte
    )
  SELECT
    geom,
    typologie_s,
    length * weight AS lane_value,
  FROM weight_cte
);

-- ****************************************************************************************************************************************************
-- ISOLINES
-- ****************************************************************************************************************************************************

-- @block Find nearby bike parkings with more than 15 spots
CALL `carto-un`.carto.CREATE_ISOLINES(
  '$api_endpoint',
  '$lds_token',
  'SELECT * FROM cartobq.docs.paris_public_parkings WHERE regpar = "Vélos" AND placal > 15',
  '$project.$dataset.paris_public_parkings_bike_5min',
  'geom',
  'walk', 5 * 60, 'time',
  NULL
);

CALL `carto-un`.carto.CREATE_ISOLINES(
  '$api_endpoint',
  '$lds_token',
  'SELECT * FROM cartobq.docs.paris_public_parkings WHERE regpar = "Vélos" AND placal > 15',
  '$project.$dataset.paris_public_parkings_bike_10min',
  'geom',
  'walk', 10 * 60, 'time',
  NULL
);

-- ****************************************************************************************************************************************************
-- POLYFILL
-- ****************************************************************************************************************************************************

-- @block Enter spatial indexes
CREATE OR REPLACE TABLE $project.$dataset.paris_h3_10
CLUSTER BY (h3)
AS (
  WITH paris_boundary AS(
    SELECT ST_UNION_AGG(geometry) AS geom
     FROM cartobq.docs.paris_districts 
  )
  SELECT h3 FROM UNNEST (
    (
      SELECT `carto-un`.carto.H3_POLYFILL(geom, 10)
      FROM paris_boundary
    )
  ) AS h3
);

-- ****************************************************************************************************************************************************
-- ENRICHMENT
-- ****************************************************************************************************************************************************

-- @block Enrich the grid using points
CALL `carto-un`.carto.ENRICH_GRID(
  -- Index type
  'h3',
  -- Grid query and name of the index column
  '''
  SELECT h3 FROM cartobq.docs.paris_h3_10
  ''',
  'h3',
  -- Input query and name of the geometry column
  'SELECT id, geom FROM cartobq.docs.paris_public_parkings WHERE regpar = "Vélos"',
  'geom',
  -- Columns to enrich and aggregation function
  [('id', 'count')],
  -- Output table
  ['$project.$dataset.paris_public_parkings_bike_h3']
);


-- @block Enrich the grid using lines
CALL `carto-un`.carto.ENRICH_GRID(
  -- Index type
  'h3',
  -- Grid query and name of the index column
  '''
  SELECT h3 FROM cartobq.docs.paris_h3_10
  ''',
  'h3',
  -- Input query and name of the geometry column
  '''
  SELECT geom, lane_value 
  FROM cartobq.docs.paris_bike_all_infrastructure
  ''',
  'geom',
  -- Columns to enrich and aggregation function
  [('lane_value', 'sum')],
  -- Output table
  ['$project.$dataset.paris_bike_lane_value_h3']
);


-- @block Enrich the grid using polygons (5 min isolines)
CALL `carto-un`.carto.ENRICH_GRID_RAW(
  -- Index type
  'h3',
  -- Grid query and name of the index column
  '''
  SELECT h3 FROM cartobq.docs.paris_h3_10
  ''',
  'h3',
  -- Input query and variables to enrich
  '''
  SELECT ST_UNION_AGG(geom) AS geom, True AS placeholder
  FROM cartobq.docs.paris_public_parkings_bike_5min
  ''',
  'geom', ['placeholder'],
  -- Output table
  ['$project.$dataset.paris_public_parkings_bike_5min_h3']
);

CREATE OR REPLACE TABLE `$project.$dataset.paris_public_parkings_bike_5min_h3`
CLUSTER BY (h3)
AS (
  WITH
    areas_cte AS (
      SELECT
        h3,
        enrichment.__carto_intersection AS covered_area,
        ST_AREA(`carto-un`.carto.H3_BOUNDARY(h3)) AS total_area
      FROM cartobq.docs.paris_public_parkings_bike_5min_h3,
      UNNEST (__carto_enrichment) AS enrichment
    )
  SELECT
    h3, covered_area, total_area,
    covered_area / total_area AS covered_percentage
  FROM areas_cte
);

-- @block Enrich the grid using polygons (10 min isolines)
CALL `carto-un`.carto.ENRICH_GRID_RAW(
  -- Index type
  'h3',
  -- Grid query and name of the index column
  '''
  SELECT h3 FROM cartobq.docs.paris_h3_10
  ''',
  'h3',
  -- Input query and variables to enrich
  '''
  SELECT ST_UNION_AGG(geom) AS geom, True AS placeholder
  FROM cartobq.docs.paris_public_parkings_bike_10min
  ''',
  'geom', ['placeholder'],
  -- Output table
  ['`$project.$dataset.paris_public_parkings_bike_10min_h3`']
);

CREATE OR REPLACE TABLE `$project.$dataset.paris_public_parkings_bike_10min_h3`
CLUSTER BY (h3)
AS (
  WITH
    areas_cte AS (
      SELECT
        h3,
        enrichment.__carto_intersection AS covered_area,
        ST_AREA(`carto-un`.carto.H3_BOUNDARY(h3)) AS total_area
      FROM cartobq.docs.paris_public_parkings_bike_10min_h3,
      UNNEST (__carto_enrichment) AS enrichment
    )
  SELECT
    h3, covered_area, total_area,
    covered_area / total_area AS covered_percentage
  FROM areas_cte
);


-- @block Extract the raster to quadbin
CALL `carto-un`.carto.RASTER_ST_GETVALUE(
    'cartobq.docs.paris_nasadem_quadbin',
    (SELECT ST_UNION_AGG(geom) as geom FROM cartobq.docs.paris_districts),
    NULL,
    '$project.$dataset.paris_nasadem_quadbin_value'
);

-- @block Enrich the grid using raster
CALL `carto-un`.carto.ENRICH_GRID(
  'h3',
  R'''
  SELECT 
    h3 
  FROM
    cartobq.docs.paris_h3_10
  ''',
  'h3',
  R'''
    SELECT
      `carto-un`.carto.QUADBIN_BOUNDARY(quadbin) AS geom,
      band_1_int16 AS elevation
    FROM
      cartobq.docs.paris_nasadem_quadbin_value
  ''',
  'geom',
  [('elevation', 'avg'), ('elevation', 'min'), ('elevation', 'max')],
  ['$project.$dataset.paris_nasadem_value_h3']
);

-- @block Using a k-ring to smooth the outliers
CREATE OR REPLACE TABLE `$project.$dataset.paris_bike_elevation_h3`
CLUSTER BY h3
AS (
  WITH
    kring_cte AS (
      SELECT
        *,
        `carto-un`.carto.H3_KRING(h3, 2) AS neighbors
      FROM
        `cartobq.docs.paris_nasadem_value_h3`
    ),
    smoothing_cte AS (
      SELECT
        kring_cte.h3,
        APPROX_QUANTILES(kring.elevation_min, 2)[OFFSET(1)] AS elevation_min,
        APPROX_QUANTILES(kring.elevation_avg, 2)[OFFSET(1)] AS elevation_avg,
        APPROX_QUANTILES(kring.elevation_max, 2)[OFFSET(1)] AS elevation_max,
      FROM
        kring_cte,
        UNNEST (kring_cte.neighbors) AS neighbor_h3
      INNER JOIN
        `cartobq.docs.paris_nasadem_value_h3` kring
      ON
        neighbor_h3 = kring.h3
      GROUP BY
        h3
    )
  SELECT
    h3,
    elevation_avg,
    elevation_min,
    elevation_max,
    ABS(elevation_max - elevation_min) AS elevation_diff,
  FROM
    smoothing_cte
)
