-- @block Now, all at once
CREATE TABLE `$project.$dataset.paris_bike_variables_h3`
CLUSTER BY (h3)
AS (
  SELECT
    h3,
    COALESCE(lanes.lane_value_sum, 0) AS lane_rate,
    parkings.id_count AS parking_count,
    COALESCE(park_5.covered_percentage, 0) AS five_min_walking,
    COALESCE(park_10.covered_percentage, 0) AS ten_min_walking,
    COALESCE(-elevation.elevation_diff, 0) AS elevation_diff
  FROM cartobq.docs.paris_h3_10
  LEFT JOIN cartobq.docs.paris_bike_lane_value_h3 lanes
  USING (h3)
  LEFT JOIN cartobq.docs.paris_public_parkings_bike_h3 parkings
  USING (h3)
  LEFT JOIN cartobq.docs.paris_public_parkings_bike_5min_h3 park_5
  USING (h3)
  LEFT JOIN cartobq.docs.paris_public_parkings_bike_10min_h3 park_10
  USING (h3)
  LEFT JOIN cartobq.docs.paris_elevation_h3 elevation
  USING (h3)
);

-- @block Creating a bike-friendliness Composite Score
CALL `carto-un`.carto.CREATE_SPATIAL_COMPOSITE_UNSUPERVISED(
  -- Input table (could also be a query)
  'cartobq.docs.paris_bike_variables_h3',
  -- Unique index
  'h3',
  -- Output table name
  '$project.$dataset.paris_bike_score_h3',
  -- Options
  '''
  {
    "scoring_method": "CUSTOM_WEIGHTS",
    "weights": {
      "lane_rate": 0.4,
      "five_min_walking": 0.3,
      "elevation_diff": 0.15,
      "ten_min_walking": 0.14,
      "parking_count": 0.01
    },
    "scaling": "STANDARD_SCALER",
    "return_range": [0.0,1.0]
  }
  '''
);
