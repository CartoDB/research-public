-- @block Workflow example
-- BEGIN CONTROL CODE
/*
Code generated by Carto Workflows Engine (RUN)
- workflowid:cc3924c0-4f6f-4b60-a94f-02ce9f7e1e0e
- versionid:0af96c344f61f6c2
*/
BEGIN
DECLARE workflowsTempDataset STRING DEFAULT 'cartodb-on-gcp-datascience.workflows_temp';
DECLARE sourceLastModified INT64;
DECLARE dependentLastModified ARRAY<STRUCT<last_modified_time INT64, table_id STRING>>;
DECLARE timeDiff INT64;
DECLARE tokens ARRAY<STRING>;
DECLARE dataset STRING;
DECLARE tableName STRING;
DECLARE i INT64 DEFAULT 0;
DECLARE j INT64 DEFAULT 0;
DECLARE sourceTables ARRAY<STRING> DEFAULT ['cartobq.docs.paris_districts','cartobq.docs.paris_bike_score_h3'];
DECLARE dependentTables ARRAY<STRING> DEFAULT
  ['WORKFLOW_a1a6855f3dd70b06_6f79b74510a4679d_result,WORKFLOW_a1a6855f3dd70b06_88f4ca70a468cb63_result,WORKFLOW_a1a6855f3dd70b06_0d3f6c45f9a8288a_result,WORKFLOW_a1a6855f3dd70b06_d026c58924a839b5_result,WORKFLOW_a1a6855f3dd70b06_a4d5fbec800fcf98_result,WORKFLOW_a1a6855f3dd70b06_1d94bcaa42cfa363_result,paris_bike_score_per_district','WORKFLOW_a1a6855f3dd70b06_0d3f6c45f9a8288a_result,WORKFLOW_a1a6855f3dd70b06_d026c58924a839b5_result,WORKFLOW_a1a6855f3dd70b06_a4d5fbec800fcf98_result,WORKFLOW_a1a6855f3dd70b06_1d94bcaa42cfa363_result,paris_bike_score_per_district'];
DECLARE dependentTablesArray ARRAY<STRING>;

LOOP
  SET i = i + 1;
  IF i > ARRAY_LENGTH(sourceTables) THEN
    LEAVE;
  END IF;
  SET tokens = SPLIT(sourceTables[ORDINAL(i)], '.');
  SET dataset = tokens[OFFSET(0)] || '.' || tokens[OFFSET(1)];
  SET tableName = tokens[OFFSET(2)];
  EXECUTE IMMEDIATE
    'SELECT last_modified_time FROM `' || dataset || '.__TABLES__` WHERE table_id = \''
      || tableName || '\''
  INTO sourceLastModified;
  SET dependentTablesArray = SPLIT(dependentTables[ORDINAL(i)], ',');
  EXECUTE IMMEDIATE
    'SELECT ARRAY_AGG(STRUCT(last_modified_time, table_id)) FROM `'
      || workflowsTempDataset || '.__TABLES__` WHERE table_id IN UNNEST([\''
      || ARRAY_TO_STRING(dependentTablesArray, '\',\'') || '\'])'
  INTO dependentLastModified;
  SET j = 0;
  LOOP
    SET j = j + 1;
    IF j > ARRAY_LENGTH(dependentLastModified) THEN
      LEAVE;
    END IF;
    IF dependentLastModified[ORDINAL(j)].last_modified_time < sourceLastModified THEN
      EXECUTE IMMEDIATE 'DROP TABLE IF EXISTS `' || workflowsTempDataset || '.'
        || dependentLastModified[ORDINAL(j)].table_id || '`';
    END IF;
  END LOOP;
END LOOP;
END;
-- END CONTROL CODE

/*==================== native.refactorcolumns (v1) [b0ef240e-b941-4d11-bb42-8dd7440e9e71]  ====================*/
BEGIN
CREATE TABLE IF NOT EXISTS `cartodb-on-gcp-datascience.workflows_temp.WORKFLOW_a1a6855f3dd70b06_6f79b74510a4679d_result`
CLUSTER BY geom
OPTIONS (
  expiration_timestamp = TIMESTAMP_ADD(
    CURRENT_TIMESTAMP(), INTERVAL 30 DAY
  )
)
AS
  SELECT
    l_ar AS district_no,
    l_aroff AS district_name,
    geom AS geom
  FROM `cartobq.docs.paris_districts`;
END;

/*==================== native.h3polyfill (v1) [5b9c7dbf-b0aa-4341-a3e6-53a6784a1180]  ====================*/
BEGIN
CREATE TABLE IF NOT EXISTS `cartodb-on-gcp-datascience.workflows_temp.WORKFLOW_a1a6855f3dd70b06_88f4ca70a468cb63_result`
CLUSTER BY h3
OPTIONS (
  expiration_timestamp = TIMESTAMP_ADD(
    CURRENT_TIMESTAMP(), INTERVAL 30 DAY
  )
)
AS
  WITH __h3 AS
  (
    SELECT
    *, `carto-un.carto`.H3_POLYFILL(
        geom, 10
      ) h3s
    FROM `cartodb-on-gcp-datascience.workflows_temp.WORKFLOW_a1a6855f3dd70b06_6f79b74510a4679d_result`
  )
  SELECT * EXCEPT(h3s)
  FROM __h3, __h3.h3s AS h3;
END;

/*==================== native.join (v1.1) [3f9e039a-a320-46c9-8ea9-ee662f24ce89]  ====================*/
BEGIN
DECLARE alias STRING;
EXECUTE IMMEDIATE
'''
  with __alias AS(
    SELECT CONCAT(
      '_joined.', column_name, ' AS ', column_name, '_joined'
    ) col_alias
    FROM `cartobq.docs`.INFORMATION_SCHEMA.COLUMNS
  WHERE table_name = 'paris_bike_score_h3'
  )
  SELECT STRING_AGG(col_alias, ', ')
  FROM __alias
'''
INTO alias;
EXECUTE IMMEDIATE
FORMAT(
'''
  CREATE TABLE IF NOT EXISTS `cartodb-on-gcp-datascience.workflows_temp.WORKFLOW_a1a6855f3dd70b06_0d3f6c45f9a8288a_result`
  OPTIONS (
    expiration_timestamp = TIMESTAMP_ADD(
      CURRENT_TIMESTAMP(), INTERVAL 30 DAY
    )
  )
  AS
    SELECT
      _main.*,
      %s
    FROM
      `cartodb-on-gcp-datascience.workflows_temp.WORKFLOW_a1a6855f3dd70b06_88f4ca70a468cb63_result` AS _main
    INNER JOIN
      `cartobq.docs.paris_bike_score_h3` AS _joined
    ON
      _main.h3 = _joined.h3;
''',
alias
);
END;

/*==================== native.groupby (v1) [2019c1d5-1d38-443e-a3a3-8946a36d1657]  ====================*/
BEGIN
CREATE TABLE IF NOT EXISTS `cartodb-on-gcp-datascience.workflows_temp.WORKFLOW_a1a6855f3dd70b06_d026c58924a839b5_result`
CLUSTER BY geom_any
OPTIONS (
  expiration_timestamp = TIMESTAMP_ADD(
    CURRENT_TIMESTAMP(), INTERVAL 30 DAY
  )
)
AS
  SELECT district_name,district_no,
    AVG(spatial_score_joined) spatial_score_joined_avg,
    ANY_VALUE(geom) geom_any
  FROM `cartodb-on-gcp-datascience.workflows_temp.WORKFLOW_a1a6855f3dd70b06_0d3f6c45f9a8288a_result`
  GROUP BY district_name,district_no;
END;

/*==================== native.refactorcolumns (v1) [614664fe-f029-4619-a407-5fad47148803]  ====================*/
BEGIN
CREATE TABLE IF NOT EXISTS `cartodb-on-gcp-datascience.workflows_temp.WORKFLOW_a1a6855f3dd70b06_a4d5fbec800fcf98_result`
CLUSTER BY geom
OPTIONS (
  expiration_timestamp = TIMESTAMP_ADD(
    CURRENT_TIMESTAMP(), INTERVAL 30 DAY
  )
)
AS
  SELECT
    district_no AS id,
    district_name AS name,
    spatial_score_joined_avg AS bike_friendliness,
    geom_any AS geom
  FROM `cartodb-on-gcp-datascience.workflows_temp.WORKFLOW_a1a6855f3dd70b06_d026c58924a839b5_result`;
END;

/*==================== native.orderby (v1.0.1) [41a3d51a-2f03-41a8-b4b3-d1d45719c3b1]  ====================*/
BEGIN
CREATE TABLE IF NOT EXISTS `cartodb-on-gcp-datascience.workflows_temp.WORKFLOW_a1a6855f3dd70b06_1d94bcaa42cfa363_result`
OPTIONS (
  expiration_timestamp = TIMESTAMP_ADD(
    CURRENT_TIMESTAMP(), INTERVAL 30 DAY
  )
)
AS
  SELECT
    *
  FROM
    `cartodb-on-gcp-datascience.workflows_temp.WORKFLOW_a1a6855f3dd70b06_a4d5fbec800fcf98_result`
  ORDER BY
    bike_friendliness DESC ;
END;

/*==================== native.saveastable (v1) [6646c8ca-eba2-49c2-b87d-4e7c95913736]  ====================*/
BEGIN
DROP TABLE IF EXISTS `cartobq.docs.paris_bike_score_per_district`;
CREATE TABLE IF NOT EXISTS `cartobq.docs.paris_bike_score_per_district`
CLUSTER BY geom
AS
  SELECT * FROM `cartodb-on-gcp-datascience.workflows_temp.WORKFLOW_a1a6855f3dd70b06_1d94bcaa42cfa363_result`;
END;

/*==================== SaveToBucketAndNotify (v1) [98cf3cc9-7adb-4dd9-a714-544187b4479e]  ====================*/
BEGIN

        DECLARE file_id STRING DEFAULT GENERATE_UUID();
        DECLARE response STRING;
        DECLARE bucket STRING DEFAULT 'carto-tnt-gcp-us-east1-export-storage';
        DECLARE bucket_url STRING DEFAULT CONCAT(
          'https://storage.googleapis.com/',
          bucket,
          '/',
          file_id,
          '-000000000000.csv.gz');
        DECLARE headers STRING DEFAULT '''
        { "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhIjoiYWNfbHFlM3p3Z3UiLCJqdGkiOiJkNmM2ZWQxYyJ9.BSFhope8VdL33gtOOlqEH0NYBAMkO8hsR5plnPajCjA",
          "Content-Type": "application/json"
        }''';
        DECLARE payload STRING DEFAULT FORMAT('''
            { "method": "email",
              "payload": {
                "email": "giulia@carto.com",
                "subject": "SDSB Paris 2023 - Score per district",
                "body": "Hey, it seems like the results you wanted just came in! 🚲<br>Click in this link to download your table: {{ bucketUrl }}",
                "replacements": {
                  "bucketUrl": "%s"
                }
              }
            }''', bucket_url);
        EXPORT DATA
          OPTIONS (
            uri = CONCAT('gs://', bucket, '/', file_id, '-*.csv.gz'),
            format = 'CSV',
            overwrite = true,
            compression = 'GZIP',
        header = true,
        field_delimiter = ','
        
        )
        AS (
          SELECT * FROM `cartodb-on-gcp-datascience.workflows_temp.WORKFLOW_a1a6855f3dd70b06_1d94bcaa42cfa363_result`
        );
        SET response = `carto-un.carto.__REQUEST`(
          'post', 'https://gcp-us-east1.api.carto.com',
          'v3/workflows/notify', payload, headers
        );
      
END;