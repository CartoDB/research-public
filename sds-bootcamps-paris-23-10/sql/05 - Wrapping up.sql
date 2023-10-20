-- @block Get accidents within the hotspots' k-ring
SELECT
  Num_Acc,
  date,
  grav,
  trajet,
  geom
FROM
  cartobq.docs.paris_bike_accidents
WHERE
  `carto-un`.carto.H3_FROMGEOGPOINT(geom, 10) IN (
    SELECT DISTINCT
      neighbors AS h3
    FROM
      cartobq.docs.paris_bike_accidents_vs_score,
      UNNEST (`carto-un`.carto.H3_KRING(h3, 3)) AS neighbors
    WHERE
      high_levels = 'accidents'
  )

-- @block Compute the isolines for Vélib' stations with more than 30 spots
CALL `carto-un`.carto.CREATE_ISOLINES(
  '$api_endpoint',
  '$lds_token',
  'SELECT * FROM cartobq.docs.paris_velib_parkings WHERE ST_INTERSECTS(geom, (SELECT ST_UNION_AGG(geom) AS geom FROM `cartobq.docs.paris_districts`)) AND capacity > 30',
  '$project.$dataset.paris_velib_parkings_coverage_areas',
  'geom',
  'walk', 15 * 60, 'time',
  NULL
);

CREATE OR REPLACE TABLE `$project.$dataset.paris_velib_parkings_coverage_areas`
CLUSTER BY geom
AS (
  SELECT
    ST_UNION_AGG(geom) AS geom
  FROM
    `$project.$dataset.paris_velib_parkings_coverage_areas`
);

-- @block Find the best spots for new BiciMad stations
CREATE OR REPLACE TABLE `$project.$dataset.paris_velib_parkings_candidates`
CLUSTER BY h3
AS (
  SELECT
    h3
  FROM 
    cartobq.docs.paris_bike_accidents_vs_score
  WHERE
    high_levels = 'both'
    AND NOT ST_INTERSECTS(
      (
        SELECT 
          geom 
        FROM 
          `cartobq.docs.paris_velib_parkings_coverage_areas`
      ),
      `carto-un`.carto.H3_BOUNDARY(h3)
    )
);
