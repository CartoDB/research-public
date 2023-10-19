-- @block Snap accidents to the H3 grid
CALL `carto-un`.carto.ENRICH_GRID(
  'h3',
  '''
  SELECT h3 FROM cartobq.docs.paris_h3_10
  ''',
  'h3',
  '''
  SELECT
    geom,
    grav,
    True as accident
  FROM cartobq.docs.paris_bike_accidents
  ''',
  'geom',
  [('accident', 'count'), ('grav', 'max')],
  ['$project.$dataset.paris_bike_accidents_h3']
);

-- @block Find hotspots for the bike-friendliness score
CALL `carto-un`.carto.GETIS_ORD_H3_TABLE(
    'cartobq.docs.paris_bike_score_h3',
    '$project.$dataset.paris_bike_score_gi',
    'h3',
    'spatial_score',
    3,
    'gaussian'
);

-- @block Find hotspots for the bike accidents
CALL `carto-un`.carto.GETIS_ORD_H3_TABLE(
    'cartobq.docs.paris_bike_accidents_h3',
    '$project.$dataset.paris_bike_accidents_gi',
    'h3',
    'accident_count',
    3,
    'gaussian'
);

-- @block Find joint or disjoint hotspots
CREATE OR REPLACE TABLE `$project.$dataset.paris_bike_accidents_vs_score`
CLUSTER BY (h3)
AS (
  WITH
    gi_grid AS (
      SELECT
        index AS h3,
        ind.gi AS score_gi,
        acc.gi AS acc_gi
      FROM
        (
          SELECT * FROM cartobq.docs.paris_bike_score_gi
          WHERE p_value < 0.01 AND gi > 0
        ) AS ind
      FULL OUTER JOIN
        (
          SELECT * FROM cartobq.docs.paris_bike_accidents_gi
          WHERE p_value < 0.01 AND gi > 0

        ) AS acc
      USING (index)
    )
  SELECT
    h3,
    CASE
      WHEN score_gi IS NOT NULL AND acc_gi IS NOT NULL THEN 'both'
      WHEN score_gi IS NOT NULL THEN 'score'
      WHEN acc_gi IS NOT NULL THEN 'accidents'
      ELSE 'none'
    END AS high_levels
  FROM gi_grid
)
