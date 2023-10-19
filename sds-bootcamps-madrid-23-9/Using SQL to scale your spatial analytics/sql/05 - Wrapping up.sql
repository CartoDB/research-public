-- @block Get accidents within the hotspots' k-ring
SELECT
  id,
  date,
  accident_type,
  n_involved,
  involved,
  max_severity,
  weather,
  geom
FROM
  cartobq.docs.madrid_bike_accidents
WHERE
  `carto-un`.carto.H3_FROMGEOGPOINT(geom, 10) IN (
    SELECT DISTINCT
      neighbors AS h3
    FROM
      cartobq.docs.madrid_bike_accidents_vs_index,
      UNNEST (`carto-un`.carto.H3_KRING(h3, 3)) AS neighbors
    WHERE
      high_levels = 'accidents'
  )

-- @block Compute the isolines for BiciMad stations
CALL `carto-un`.carto.CREATE_ISOLINES(
  '$api_endpoint',
  '$lds_token',
  'cartobq.docs.madrid_bicimad_stations',
  '$project.$dataset.madrid_bicimad_coverage_areas',
  'geom',
  'walk', 15 * 60, 'time',
  NULL
);

CREATE OR REPLACE TABLE `$project.$dataset.madrid_bicimad_coverage_area`
AS (
  SELECT
    ST_UNION_AGG(geom) AS geom
  FROM
    `$project.$dataset.madrid_bicimad_coverage_areas`
);

-- @block Find the best spots for new BiciMad stations
CREATE OR REPLACE TABLE `$project.$dataset.madrid_bicimad_candidates`
CLUSTER BY h3
AS (
  SELECT
    h3
  FROM 
    cartobq.docs.madrid_bike_index_gi_sept
  WHERE
    p_value < 0.00001 
    AND gi >= 10
    AND NOT ST_INTERSECTS(
      (
        SELECT 
          geom 
        FROM 
          `cartobq.docs.madrid_bicimad_coverage_area`
      ),
      `carto-un`.carto.H3_BOUNDARY(h3)
    )
);
