-- @block Snap accidents to the H3 grid
CALL `carto-un`.carto.ENRICH_GRID(
  'h3',
  '''
  SELECT h3 FROM cartobq.docs.madrid_h3_10
  ''',
  'h3',
  '''
  SELECT
    geom,
    n_involved,
    max_severity,
    True as accident
  FROM cartobq.docs.madrid_bike_accidents
  ''',
  'geom',
  [('n_involved', 'sum'), ('accident', 'count'), ('max_severity', 'avg')],
  ['`$project.$dataset.madrid_bike_accidents_h3`']
);

-- @block Computing Getis-Ord
CREATE OR REPLACE TABLE `$project.$dataset.madrid_bike_index_gi`
CLUSTER BY (h3)
AS (
  SELECT
    getis_ord.index AS h3,
    getis_ord.gi AS gi,
    getis_ord.p_value AS p_value
  FROM
    UNNEST ((
      SELECT
        `carto-un`.carto.GETIS_ORD_H3(
          ARRAY_AGG(STRUCT(h3, spatial_score)),
          3, 'gaussian'
        ) AS getis_ord
      FROM
        cartobq.docs.madrid_bike_index_h3
    )) AS getis_ord
);

CREATE OR REPLACE TABLE TABLE `$project.$dataset.madrid_bike_accidents_gi`
CLUSTER BY (h3)
AS (
  SELECT
    getis_ord.index AS h3,
    getis_ord.gi AS gi,
    getis_ord.p_value AS p_value
  FROM
    UNNEST ((
      SELECT
        `carto-un`.carto.GETIS_ORD_H3(
          ARRAY_AGG(STRUCT(h3, accident_count)),
          3, 'gaussian'
        ) AS getis_ord
      FROM
        cartobq.docs.madrid_bike_accidents_h3
    )) AS getis_ord
);

-- @block Finding joint or disjoint hotspots
CREATE OR REPLACE TABLE `$project.$dataset.madrid_bike_accidents_vs_index_sept`
CLUSTER BY (h3)
AS (
  WITH
    gi_grid AS (
      SELECT
        h3,
        ind.gi AS index_gi,
        acc.gi AS acc_gi
      FROM
        (
          SELECT * FROM cartobq.docs.madrid_bike_index_gi_sept
          WHERE p_value < 0.001 AND gi > 5
        ) AS ind
      FULL OUTER JOIN
        (
          SELECT * FROM cartobq.docs.madrid_bike_accidents_gi
          WHERE p_value < 0.001 AND gi > 5

        ) AS acc
      USING (h3)
    )
  SELECT
    h3,
    CASE
      WHEN index_gi IS NOT NULL AND acc_gi IS NOT NULL THEN 'both'
      WHEN index_gi IS NOT NULL THEN 'index'
      WHEN acc_gi IS NOT NULL THEN 'accidents'
      ELSE 'none'
    END AS high_levels
  FROM gi_grid
)
