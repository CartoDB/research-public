-- @block Consolidating all infrastructure
CREATE OR REPLACE TABLE `$project.$dataset.madrid_bike_all_infrastructure`
CLUSTER BY (geom)
AS (
  WITH
    infra_cte AS (
      SELECT geom, length, usage_type
      FROM `cartobq.docs.madrid_bike_infrastructure`
      UNION ALL
      SELECT geom, length, usage_type
      FROM `cartobq.docs.madrid_bike_quiet_streets`
    ),
    weight_cte AS (
      SELECT
        geom,
        usage_type,
        length,
        CASE
          WHEN usage_type = 'CALLE TRANQUILA' THEN 0.2
          WHEN usage_type = 'GIROS Y SENTIDOS' THEN 0.3
          WHEN usage_type = 'VÍA USO COMPARTIDO' THEN 0.3
          WHEN usage_type = 'VÍA PREFERENTE BICI' THEN 0.5
          WHEN usage_type = 'VÍA EXCLUSIVA BICI' THEN 0.8
          WHEN usage_type = 'ANILLO VERDE CICLISTA' THEN 1
        END AS weight
      FROM
        infra_cte
    )
  SELECT
    geom,
    usage_type,
    length * weight AS lane_value,
  FROM weight_cte
);

-- @block Find nearby bike parkings
CALL `carto-un`.carto.CREATE_ISOLINES(
  '$api_endpoint',
  '$lds_token',
  'cartobq.docs.madrid_bike_parkings',
  '$project.$dataset.madrid_bike_parkings_5min',
  'geom',
  'walk', 5 * 60, 'time',
  NULL
);

CALL `carto-un`.carto.CREATE_ISOLINES(
  '$api_endpoint',
  '$lds_token',
  'cartobq.docs.madrid_bike_parkings',
  '$project.$dataset.madrid_bike_parkings_10min',
  'geom',
  'walk', 10 * 60, 'time',
  NULL
);


-- @block Enter spatial indexes
CREATE OR REPLACE TABLE $project.$dataset.madrid_h3_10
CLUSTER BY (h3)
AS (
  SELECT h3 FROM UNNEST (
    (
      SELECT `carto-un`.carto.H3_POLYFILL(geom, 10)
      FROM cartobq.docs.madrid_city_boundaries
    )
  ) AS h3
);


-- @block Enrich the grid using points
CALL `carto-un`.carto.ENRICH_GRID(
  -- Index type
  'h3',
  -- Grid query and name of the index column
  '''
  SELECT h3 FROM cartobq.docs.madrid_h3_10
  ''',
  'h3',
  -- Input query and name of the geometry column
  'SELECT id, geom FROM cartobq.docs.madrid_bike_parkings',
  'geom',
  -- Columns to enrich and aggregation function
  [('id', 'count')],
  -- Output table
  ['$project.$dataset.madrid_bike_parkings_h3']
);


-- @block Enrich the grid using lines
CALL `carto-un`.carto.ENRICH_GRID(
  -- Index type
  'h3',
  -- Grid query and name of the index column
  '''
  SELECT h3 FROM cartobq.docs.madrid_h3_10
  ''',
  'h3',
  -- Input query and name of the geometry column
  '''
  SELECT geom, lane_level 
  FROM cartobq.docs.madrid_bike_all_infrastructure
  ''',
  'geom',
  -- Columns to enrich and aggregation function
  [('lane_level', 'sum')],
  -- Output table
  ['$project.$dataset.madrid_bike_lane_level_h3']
);


-- @block Enrich the grid using polygons
CALL `carto-un`.carto.ENRICH_GRID_RAW(
  -- Index type
  'h3',
  -- Grid query and name of the index column
  '''
  SELECT h3 FROM cartobq.docs.madrid_h3_10
  ''',
  'h3',
  -- Input query and variables to enrich
  '''
  SELECT ST_SIMPLIFY(geom, 20) AS geom, True AS placeholder
  FROM cartobq.docs.madrid_bike_parkings_5min_area
  ''',
  'geom', ['placeholder'],
  -- Output table
  ['$project.$dataset.madrid_bike_parkings_5min_h3']
);

CREATE OR REPLACE TABLE `$project.$dataset.madrid_bike_parkings_5min_h3`
CLUSTER BY (h3)
AS (
  WITH
    areas_cte AS (
      SELECT
        h3,
        enrichment.__carto_intersection AS covered_area,
        ST_AREA(`carto-un`.carto.H3_BOUNDARY(h3)) AS total_area
      FROM cartobq.docs.madrid_bike_parkings_5min_h3,
      UNNEST (__carto_enrichment) AS enrichment
    )
  SELECT
    h3, covered_area, total_area,
    covered_area / total_area AS covered_percentage
  FROM areas_cte
);

CALL `carto-un`.carto.ENRICH_GRID_RAW(
  -- Index type
  'h3',
  -- Grid query and name of the index column
  '''
  SELECT h3 FROM cartobq.docs.madrid_h3_10
  ''',
  'h3',
  -- Input query and variables to enrich
  '''
  SELECT ST_SIMPLIFY(geom, 20) AS geom, True AS placeholder
  FROM cartobq.docs.madrid_bike_parkings_10min_area
  ''',
  'geom', ['placeholder'],
  -- Output table
  ['`$project.$dataset.madrid_bike_parkings_10min_h3`']
);

CREATE OR REPLACE TABLE `$project.$dataset.madrid_bike_parkings_10min_h3`
CLUSTER BY (h3)
AS (
  WITH
    areas_cte AS (
      SELECT
        h3,
        enrichment.__carto_intersection AS covered_area,
        ST_AREA(`carto-un`.carto.H3_BOUNDARY(h3)) AS total_area
      FROM cartobq.docs.madrid_bike_parkings_10min_h3,
      UNNEST (__carto_enrichment) AS enrichment
    )
  SELECT
    h3, covered_area, total_area,
    covered_area / total_area AS covered_percentage
  FROM areas_cte
);


-- @block Extract the raster to quadbin
CALL `carto-un`.carto.RASTER_ST_GETVALUE(
    'cartobq.docs.madrid_bike_nasadem',
    (SELECT geom FROM cartobq.docs.madrid_city_boundaries),
    NULL,
    '$project.$dataset.madrid_bike_nasadem_quadbin'
);

-- @block Enrich the grid using raster
CALL `carto-un`.carto.ENRICH_GRID(
  'h3',
  R'''
  SELECT 
    h3 
  FROM
    cartobq.docs.madrid_h3_10
  WHERE
    MOD(`carto-un`.carto.H3_STRING_TOINT(h3), 3) = 0
  ''',
  'h3',
  R'''
    SELECT
      `carto-un`.carto.QUADBIN_BOUNDARY(quadbin) AS geom,
      band_1_int16 AS elevation
    FROM
      `cartobq.docs.madrid_bike_nasadem_quadbin`
  ''',
  'geom',
  [('elevation', 'avg'), ('elevation', 'min'), ('elevation', 'max')],
  ['`$project.$dataset.madrid_bike_nasadem_h3_mod0`']
);

CALL `carto-un`.carto.ENRICH_GRID(
  'h3',
  R'''
  SELECT 
    h3 
  FROM cartobq.docs.madrid_h3_10
    WHERE MOD(`carto-un`.carto.H3_STRING_TOINT(h3), 3) = 1
  ''',
  'h3',
  R'''
    SELECT
      `carto-un`.carto.QUADBIN_BOUNDARY(quadbin) AS geom,
      band_1_int16 AS elevation
    FROM
      `cartobq.docs.madrid_bike_nasadem_quadbin`
  ''',
  'geom',
  [('elevation', 'avg'), ('elevation', 'min'), ('elevation', 'max')],
  ['`$project.$dataset.madrid_bike_nasadem_h3_mod1`']
);

CALL `carto-un`.carto.ENRICH_GRID(
  'h3',
  R'''
  SELECT 
    h3 
  FROM cartobq.docs.madrid_h3_10
    WHERE MOD(`carto-un`.carto.H3_STRING_TOINT(h3), 3) = 2
  ''',
  'h3',
  R'''
    SELECT
      `carto-un`.carto.QUADBIN_BOUNDARY(quadbin) AS geom,
      band_1_int16 AS elevation
    FROM
      `cartobq.docs.madrid_bike_nasadem_quadbin`
  ''',
  'geom',
  [('elevation', 'avg'), ('elevation', 'min'), ('elevation', 'max')],
  ['`$project.$dataset.madrid_bike_nasadem_h3_mod2`']
);

-- @block Aggregate the partials
CREATE OR REPLACE TABLE `$project.$dataset.madrid_bike_nasadem_h3`
CLUSTER BY h3
AS (
  SELECT * FROM `$project.$dataset.madrid_bike_nasadem_h3_mod0`
  UNION ALL
  SELECT * FROM `$project.$dataset.madrid_bike_nasadem_h3_mod1`
  UNION ALL
  SELECT * FROM `$project.$dataset.madrid_bike_nasadem_h3_mod2`
);

DROP TABLE `$project.$dataset.madrid_bike_nasadem_h3_mod0`;
DROP TABLE `$project.$dataset.madrid_bike_nasadem_h3_mod1`;
DROP TABLE `$project.$dataset.madrid_bike_nasadem_h3_mod2`;

-- @block Using a k-ring to smooth the outliers
CREATE OR REPLACE TABLE `$project.$dataset.madrid_bike_elevation_h3`
CLUSTER BY h3
AS (
  WITH
    kring_cte AS (
      SELECT
        *,
        `carto-un`.carto.H3_KRING(h3, 2) AS neighbors
      FROM
        `cartobq.docs.madrid_bike_nasadem_h3`
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
        `cartobq.docs.madrid_bike_nasadem_h3` kring
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
