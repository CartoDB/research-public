-- WARNING: This procedure requires the Analytics Toolbox and assumes it will be located
-- at the following path: carto-un.carto. If you want to deploy and
-- run it in a different location, you will need to update the code accordingly.
CREATE OR REPLACE PROCEDURE
  `cartodb-on-gcp-datascience.workflows_temp.wfproc_992fd10bed7791df`(
)
BEGIN
  /*
   {"versionId":"a4c6c29a78872f39","paramsId":"97d170e1550eee4a","isImmutable":false,"diagramJson":"{\"title\":\"(5/) GeoPython25 - Unlocking Smarter Property Risk Assessments with Spatio-Temporal Crime Insights and CARTO\",\"description\":\"\",\"nodes\":[{\"id\":\"b4ecec01-7c7c-4399-9be5-2977982f114b\",\"data\":{\"name\":\"native.timeseriesclustering\",\"label\":\"Cluster Time Series\",\"inputs\":[{\"name\":\"source\",\"type\":\"Table\",\"title\":\"Source table\",\"description\":\"Source table\"},{\"name\":\"partitioning_col\",\"type\":\"Column\",\"title\":\"Partition column\",\"helper\":\"Each unique value on this column will be assigned a cluster\",\"parent\":\"source\",\"dataType\":[\"string\",\"number\"],\"description\":\"Partition column\",\"value\":\"h3\"},{\"name\":\"ts_col\",\"type\":\"Column\",\"title\":\"Timestamp column\",\"parent\":\"source\",\"dataType\":[\"datetime\",\"timestamp\",\"date\"],\"description\":\"Timestamp column\",\"value\":\"week\"},{\"name\":\"value_col\",\"type\":\"Column\",\"title\":\"Value column\",\"helper\":\"Clusters will be calculated based on the value of this column along time\",\"parent\":\"source\",\"dataType\":[\"number\"],\"description\":\"Value column\",\"value\":\"counts\"},{\"name\":\"method\",\"type\":\"Selection\",\"title\":\"Algorithm\",\"helper\":\"Method to compare the time series\",\"options\":[\"Value\",\"Profile\"],\"description\":\"Algorithm\",\"value\":\"Value\"},{\"name\":\"n_clusters\",\"type\":\"Number\",\"title\":\"Number of clusters\",\"description\":\"Number of clusters\",\"value\":4},{\"name\":\"optimizationcol\",\"value\":\"h3\"}],\"version\":\"1\"},\"type\":\"generic\",\"width\":64,\"height\":64,\"zIndex\":2,\"dragging\":false,\"position\":{\"x\":496,\"y\":272},\"selected\":false,\"positionAbsolute\":{\"x\":496,\"y\":272}},{\"id\":\"b4ecec01-7c7c-4399-9be5-2977982f114b-1725528351591\",\"data\":{\"name\":\"native.timeseriesclustering\",\"label\":\"Cluster Time Series\",\"inputs\":[{\"name\":\"source\",\"type\":\"Table\",\"title\":\"Source table\",\"description\":\"Source table\"},{\"name\":\"partitioning_col\",\"type\":\"Column\",\"title\":\"Partition column\",\"helper\":\"Each unique value on this column will be assigned a cluster\",\"parent\":\"source\",\"dataType\":[\"string\",\"number\"],\"description\":\"Partition column\",\"value\":\"h3\"},{\"name\":\"ts_col\",\"type\":\"Column\",\"title\":\"Timestamp column\",\"parent\":\"source\",\"dataType\":[\"datetime\",\"timestamp\",\"date\"],\"description\":\"Timestamp column\",\"value\":\"week\"},{\"name\":\"value_col\",\"type\":\"Column\",\"title\":\"Value column\",\"helper\":\"Clusters will be calculated based on the value of this column along time\",\"parent\":\"source\",\"dataType\":[\"number\"],\"description\":\"Value column\",\"value\":\"counts\"},{\"name\":\"method\",\"type\":\"Selection\",\"title\":\"Algorithm\",\"helper\":\"Method to compare the time series\",\"options\":[\"Value\",\"Profile\"],\"description\":\"Algorithm\",\"value\":\"Profile\"},{\"name\":\"n_clusters\",\"type\":\"Number\",\"title\":\"Number of clusters\",\"description\":\"Number of clusters\",\"value\":4},{\"name\":\"optimizationcol\",\"value\":\"h3\"}],\"version\":\"1\"},\"type\":\"generic\",\"width\":64,\"height\":64,\"zIndex\":2,\"dragging\":false,\"position\":{\"x\":496,\"y\":576},\"selected\":false,\"positionAbsolute\":{\"x\":496,\"y\":576}},{\"id\":\"d14ca13d-e488-4f6e-a26c-95c7eb768c5a\",\"data\":{\"name\":\"native.renamecolumn\",\"label\":\"Rename Column\",\"inputs\":[{\"name\":\"source\",\"type\":\"Table\",\"title\":\"Source table\",\"description\":\"Source table\"},{\"name\":\"column\",\"type\":\"Column\",\"title\":\"Column to rename\",\"parent\":\"source\",\"dataType\":[\"boolean\",\"geography\",\"number\",\"string\"],\"description\":\"Column to rename\",\"value\":\"cluster\"},{\"name\":\"newname\",\"type\":\"String\",\"title\":\"New column name\",\"validation\":\"^[a-zA-Z_][a-zA-Z0-9_]*$\",\"allowExpressions\":false,\"description\":\"New column name\",\"value\":\"cluster_value\"},{\"name\":\"optimizationcol\",\"value\":\"h3\"}],\"version\":\"1\"},\"type\":\"generic\",\"width\":64,\"height\":64,\"zIndex\":2,\"dragging\":false,\"position\":{\"x\":784,\"y\":272},\"selected\":false,\"positionAbsolute\":{\"x\":784,\"y\":272}},{\"id\":\"d14ca13d-e488-4f6e-a26c-95c7eb768c5a-1725537061002\",\"data\":{\"name\":\"native.renamecolumn\",\"label\":\"Rename Column\",\"inputs\":[{\"name\":\"source\",\"type\":\"Table\",\"title\":\"Source table\",\"description\":\"Source table\"},{\"name\":\"column\",\"type\":\"Column\",\"title\":\"Column to rename\",\"parent\":\"source\",\"dataType\":[\"boolean\",\"geography\",\"number\",\"string\"],\"description\":\"Column to rename\",\"value\":\"cluster\"},{\"name\":\"newname\",\"type\":\"String\",\"title\":\"New column name\",\"validation\":\"^[a-zA-Z_][a-zA-Z0-9_]*$\",\"allowExpressions\":false,\"description\":\"New column name\",\"value\":\"cluster_profile\"},{\"name\":\"optimizationcol\",\"value\":\"h3\"}],\"version\":\"1\"},\"type\":\"generic\",\"width\":64,\"height\":64,\"zIndex\":2,\"dragging\":false,\"position\":{\"x\":784,\"y\":576},\"selected\":false,\"positionAbsolute\":{\"x\":784,\"y\":576}},{\"id\":\"b27a1e9b-0ca1-4af3-8c00-329e135b1b20\",\"data\":{\"name\":\"native.join\",\"label\":\"Join\",\"inputs\":[{\"name\":\"maintable\",\"type\":\"Table\",\"title\":\"Main table\",\"description\":\"Main table\"},{\"name\":\"secondarytable\",\"type\":\"Table\",\"title\":\"Secondary table\",\"description\":\"Secondary table\"},{\"name\":\"maincolumn\",\"type\":\"Column\",\"title\":\"Column in main table\",\"parent\":\"maintable\",\"dataType\":[\"boolean\",\"date\",\"datetime\",\"time\",\"timestamp\",\"number\",\"string\"],\"description\":\"Column in main table\",\"value\":\"h3\"},{\"name\":\"secondarycolumn\",\"type\":\"Column\",\"title\":\"Column in secondary table\",\"parent\":\"secondarytable\",\"dataType\":[\"boolean\",\"date\",\"datetime\",\"time\",\"timestamp\",\"number\",\"string\"],\"description\":\"Column in secondary table\",\"value\":\"h3\"},{\"name\":\"jointype\",\"type\":\"Selection\",\"title\":\"Join type\",\"options\":[\"Inner\",\"Left\",\"Right\",\"Full outer\"],\"default\":\"Inner\",\"description\":\"Join type\",\"value\":\"Inner\"},{\"name\":\"optimizationcol\"}],\"version\":\"1.2\"},\"type\":\"generic\",\"width\":64,\"height\":64,\"zIndex\":2,\"dragging\":false,\"position\":{\"x\":1120,\"y\":384},\"selected\":false,\"positionAbsolute\":{\"x\":1120,\"y\":384}},{\"id\":\"1cb15037-ae9e-4fc1-a60f-4dc87d23eb57\",\"data\":{\"name\":\"native.saveastable\",\"label\":\"Save as Table\",\"inputs\":[{\"name\":\"source\",\"type\":\"Table\",\"title\":\"Source table\",\"description\":\"Source table\"},{\"name\":\"destination\",\"type\":\"OutputTable\",\"title\":\"Table details\",\"placeholder\":\"Rename and select destination\",\"description\":\"Table details\",\"value\":\"<my-project>.<my-dataset>.CHI_boundary_enriched_TS_clustering\"},{\"name\":\"append\",\"type\":\"Boolean\",\"title\":\"Append to existing table\",\"default\":false,\"description\":\"Append to existing table\",\"value\":false},{\"name\":\"optimizationcol\",\"type\":\"Column\",\"title\":\"Cluster by\",\"parent\":\"source\",\"dataType\":[\"geography\",\"boolean\",\"number\",\"string\",\"date\",\"datetime\",\"time\",\"timestamp\"],\"providers\":[\"bigquery\"],\"optional\":true,\"advanced\":true,\"description\":\"Cluster by\",\"value\":\"h3\"}],\"version\":\"1\"},\"type\":\"generic\",\"width\":64,\"height\":64,\"zIndex\":2,\"dragging\":true,\"position\":{\"x\":1616,\"y\":384},\"selected\":false,\"positionAbsolute\":{\"x\":1616,\"y\":384}},{\"id\":\"425caed9-aced-4d28-a5ea-ad8789e284c4\",\"data\":{\"name\":\"native.renamecolumn\",\"label\":\"Rename Column\",\"inputs\":[{\"name\":\"source\",\"type\":\"Table\",\"title\":\"Source table\",\"description\":\"Source table\"},{\"name\":\"column\",\"type\":\"Column\",\"title\":\"Column to rename\",\"parent\":\"source\",\"dataType\":[\"boolean\",\"geography\",\"number\",\"string\"],\"description\":\"Column to rename\",\"value\":\"cluster_profile_joined\"},{\"name\":\"newname\",\"type\":\"String\",\"title\":\"New column name\",\"validation\":\"^[a-zA-Z_][a-zA-Z0-9_]*$\",\"allowExpressions\":false,\"description\":\"New column name\",\"value\":\"cluster_profile\"},{\"name\":\"optimizationcol\",\"value\":\"h3\"}],\"version\":\"1\"},\"type\":\"generic\",\"width\":64,\"height\":64,\"zIndex\":2,\"dragging\":false,\"position\":{\"x\":1232,\"y\":384},\"selected\":false,\"positionAbsolute\":{\"x\":1232,\"y\":384}},{\"id\":\"2fa55e66-ae2b-4b4d-a7db-f5bb9dd48e78\",\"data\":{\"name\":\"Note\",\"color\":\"#8BE0A4\",\"genAi\":false,\"label\":\"\",\"width\":463.998,\"height\":735.9929999999999,\"inputs\":[],\"markdown\":\"---\\nlabel:\\n---\\n## Input data\",\"position\":{\"x\":-432.006,\"y\":-112}},\"type\":\"note\",\"width\":464,\"height\":736,\"zIndex\":-1,\"dragging\":false,\"position\":{\"x\":-160,\"y\":-16},\"selected\":false,\"positionAbsolute\":{\"x\":-160,\"y\":-16}},{\"id\":\"2fa55e66-ae2b-4b4d-a7db-f5bb9dd48e78-1726840001203\",\"data\":{\"name\":\"Note\",\"color\":\"#F89C74\",\"genAi\":false,\"label\":\"\",\"width\":1135.99,\"height\":735.9929999999999,\"inputs\":[],\"markdown\":\"---\\nlabel:\\n---\\n## Time series clustering\\nTime series clustering is a method used to group time series data into clusters based on similarities in their temporal patterns. It aims to find natural groupings among time series, where series within the same cluster are more similar to each other than to those in other clusters.\",\"position\":{\"x\":320,\"y\":-16}},\"type\":\"note\",\"width\":1136,\"height\":736,\"zIndex\":-1,\"dragging\":false,\"position\":{\"x\":320,\"y\":-16},\"selected\":false,\"positionAbsolute\":{\"x\":320,\"y\":-16}},{\"id\":\"2fa55e66-ae2b-4b4d-a7db-f5bb9dd48e78-1726840001203-1726840018481\",\"data\":{\"name\":\"Note\",\"color\":\"#FE88B1\",\"genAi\":false,\"label\":\"\",\"width\":351.999,\"height\":735.997,\"inputs\":[],\"markdown\":\"---\\nlabel:\\n---\\n## Save results to a table\",\"position\":{\"x\":1472,\"y\":-16}},\"type\":\"note\",\"width\":432,\"height\":736,\"zIndex\":-1,\"dragging\":false,\"position\":{\"x\":1472,\"y\":-16},\"selected\":false,\"positionAbsolute\":{\"x\":1472,\"y\":-16}},{\"id\":\"2fa55e66-ae2b-4b4d-a7db-f5bb9dd48e78-1726840001203-1726840063570\",\"data\":{\"name\":\"Note\",\"color\":\"#F89C74\",\"genAi\":false,\"label\":\"\",\"width\":719.994,\"height\":271.999,\"inputs\":[],\"markdown\":\"---\\nlabel: By value\\n---\\nThe series is clustered based on the **step-by-step distance of its values**. One way to think of it is that the closer the signals, the closer the series will be understood to be and the higher the chance of being clustered together.\",\"position\":{\"x\":79.998,\"y\":48}},\"type\":\"note\",\"width\":720,\"height\":272,\"zIndex\":-1,\"dragging\":false,\"position\":{\"x\":352,\"y\":144},\"selected\":false,\"positionAbsolute\":{\"x\":352,\"y\":144}},{\"id\":\"2fa55e66-ae2b-4b4d-a7db-f5bb9dd48e78-1726840001203-1726840063570-1726840097338\",\"data\":{\"name\":\"Note\",\"color\":\"#F89C74\",\"genAi\":false,\"label\":\"\",\"width\":719.994,\"height\":271.999,\"inputs\":[],\"markdown\":\"---\\nlabel: By profile\\n---\\nThe series is clustered based on their **dynamics along the time span** passed. This time, the closer the correlation between two series, the higher the chance of being clustered together.\",\"position\":{\"x\":79.998,\"y\":336}},\"type\":\"note\",\"width\":720,\"height\":272,\"zIndex\":-1,\"dragging\":false,\"position\":{\"x\":352,\"y\":432},\"selected\":false,\"positionAbsolute\":{\"x\":352,\"y\":432}},{\"id\":\"7aaaed73-4edd-408a-b58c-fda6d2c05e40\",\"data\":{\"name\":\"Note\",\"color\":\"#8BE0A4\",\"genAi\":false,\"label\":\"\",\"width\":431.998,\"height\":207.996,\"inputs\":[],\"markdown\":\"---\\nlabel: Chicago boundary enriched and pre-processed (FAMD) data\\n---\\n\",\"position\":{\"x\":-588.803,\"y\":96}},\"type\":\"note\",\"width\":432,\"height\":208,\"zIndex\":-1,\"dragging\":false,\"position\":{\"x\":-144,\"y\":320},\"selected\":false,\"positionAbsolute\":{\"x\":-144,\"y\":320}},{\"id\":\"39ab3062-5255-48c5-b52d-6bbf8bb45944\",\"data\":{\"name\":\"native.dropcolumn\",\"label\":\"Drop Columns\",\"inputs\":[{\"name\":\"source\",\"type\":\"Table\",\"title\":\"Source table\",\"description\":\"Source table\"},{\"name\":\"column\",\"type\":\"Column\",\"title\":\"Columns to drop\",\"parent\":\"source\",\"mode\":\"multiple\",\"noDefault\":true,\"description\":\"Columns to drop\",\"value\":[\"h3_joined\"]},{\"name\":\"optimizationcol\",\"value\":\"h3\"}],\"version\":\"1\"},\"type\":\"generic\",\"width\":64,\"height\":64,\"zIndex\":2,\"dragging\":false,\"position\":{\"x\":1360,\"y\":384},\"selected\":false,\"positionAbsolute\":{\"x\":1360,\"y\":384}},{\"id\":\"dac13ed6-cca8-403e-9594-88c3a7cb9b5a\",\"data\":{\"id\":\"cartobq.sdsc24_ny_workshops.CHI_boundary_enriched\",\"name\":\"ReadTable\",\"size\":24120250,\"type\":\"table\",\"label\":\"CHI_boundary_enriched\",\"nrows\":145348,\"inputs\":[{\"name\":\"source\",\"type\":\"String\",\"title\":\"Source table\",\"value\":\"cartobq.sdsc24_ny_workshops.CHI_boundary_enriched\",\"description\":\"Read Table\"}],\"schema\":[{\"name\":\"week\",\"type\":\"timestamp\"},{\"name\":\"h3\",\"type\":\"string\"},{\"name\":\"counts\",\"type\":\"number\"},{\"name\":\"year\",\"type\":\"number\"},{\"name\":\"month\",\"type\":\"number\"},{\"name\":\"total_pop_sum\",\"type\":\"number\"},{\"name\":\"median_age_avg\",\"type\":\"number\"},{\"name\":\"median_rent_avg\",\"type\":\"number\"},{\"name\":\"black_pop_sum\",\"type\":\"number\"},{\"name\":\"hispanic_pop_sum\",\"type\":\"number\"},{\"name\":\"owner_occupied_housing_units_median_value_sum\",\"type\":\"number\"},{\"name\":\"vacant_housing_units_sum\",\"type\":\"number\"},{\"name\":\"housing_units_sum\",\"type\":\"number\"},{\"name\":\"families_with_young_children_sum\",\"type\":\"number\"},{\"name\":\"urbanity_any\",\"type\":\"string\"},{\"name\":\"urbanity_any_ordinal\",\"type\":\"number\"},{\"name\":\"principal_component_1\",\"type\":\"number\"},{\"name\":\"principal_component_2\",\"type\":\"number\"}],\"enriched\":true,\"provider\":\"bigquery\",\"geomField\":\"h3:h3\",\"tableRegion\":\"US\",\"lastModified\":1739893964832,\"optimization\":{\"actions\":[{\"type\":\"cluster\",\"enabled\":false}],\"actionAvailable\":{\"msg\":\"<b>This table isn't optimized.</b> Creating a cluster based on geospatial data may improve performance.\",\"type\":\"createTable\",\"query\":\"CREATE TABLE {newTableName} CLUSTER BY h3 AS SELECT * FROM `cartobq.sdsc24_ny_workshops.CHI_boundary_enriched`\"}},\"originalSchema\":[{\"name\":\"week\",\"type\":\"DATE\"},{\"name\":\"h3\",\"type\":\"STRING\"},{\"name\":\"counts\",\"type\":\"INTEGER\"},{\"name\":\"year\",\"type\":\"INTEGER\"},{\"name\":\"month\",\"type\":\"INTEGER\"},{\"name\":\"total_pop_sum\",\"type\":\"FLOAT\"},{\"name\":\"median_age_avg\",\"type\":\"FLOAT\"},{\"name\":\"median_rent_avg\",\"type\":\"FLOAT\"},{\"name\":\"black_pop_sum\",\"type\":\"FLOAT\"},{\"name\":\"hispanic_pop_sum\",\"type\":\"FLOAT\"},{\"name\":\"owner_occupied_housing_units_median_value_sum\",\"type\":\"FLOAT\"},{\"name\":\"vacant_housing_units_sum\",\"type\":\"FLOAT\"},{\"name\":\"housing_units_sum\",\"type\":\"FLOAT\"},{\"name\":\"families_with_young_children_sum\",\"type\":\"FLOAT\"},{\"name\":\"urbanity_any\",\"type\":\"STRING\"},{\"name\":\"urbanity_any_ordinal\",\"type\":\"INTEGER\"},{\"name\":\"principal_component_1\",\"type\":\"FLOAT\"},{\"name\":\"principal_component_2\",\"type\":\"FLOAT\"}]},\"type\":\"source\",\"zIndex\":2,\"position\":{\"x\":-48,\"y\":400},\"selected\":false}],\"edges\":[{\"id\":\"b4ecec01-7c7c-4399-9be5-2977982f114bresult-d14ca13d-e488-4f6e-a26c-95c7eb768c5asource\",\"source\":\"b4ecec01-7c7c-4399-9be5-2977982f114b\",\"target\":\"d14ca13d-e488-4f6e-a26c-95c7eb768c5a\",\"selected\":false,\"className\":\"\",\"sourceHandle\":\"result\",\"targetHandle\":\"source\",\"animated\":false},{\"id\":\"b4ecec01-7c7c-4399-9be5-2977982f114b-1725528351591result-d14ca13d-e488-4f6e-a26c-95c7eb768c5a-1725537061002source\",\"source\":\"b4ecec01-7c7c-4399-9be5-2977982f114b-1725528351591\",\"target\":\"d14ca13d-e488-4f6e-a26c-95c7eb768c5a-1725537061002\",\"selected\":false,\"className\":\"\",\"sourceHandle\":\"result\",\"targetHandle\":\"source\",\"animated\":false},{\"id\":\"b27a1e9b-0ca1-4af3-8c00-329e135b1b20result-425caed9-aced-4d28-a5ea-ad8789e284c4source\",\"source\":\"b27a1e9b-0ca1-4af3-8c00-329e135b1b20\",\"target\":\"425caed9-aced-4d28-a5ea-ad8789e284c4\",\"selected\":false,\"className\":\"\",\"sourceHandle\":\"result\",\"targetHandle\":\"source\",\"animated\":false},{\"id\":\"425caed9-aced-4d28-a5ea-ad8789e284c4result-39ab3062-5255-48c5-b52d-6bbf8bb45944source\",\"source\":\"425caed9-aced-4d28-a5ea-ad8789e284c4\",\"target\":\"39ab3062-5255-48c5-b52d-6bbf8bb45944\",\"className\":\"\",\"sourceHandle\":\"result\",\"targetHandle\":\"source\",\"animated\":false},{\"id\":\"reactflow__edge-39ab3062-5255-48c5-b52d-6bbf8bb45944result-1cb15037-ae9e-4fc1-a60f-4dc87d23eb57source\",\"source\":\"39ab3062-5255-48c5-b52d-6bbf8bb45944\",\"target\":\"1cb15037-ae9e-4fc1-a60f-4dc87d23eb57\",\"sourceHandle\":\"result\",\"targetHandle\":\"source\",\"animated\":false},{\"id\":\"reactflow__edge-d14ca13d-e488-4f6e-a26c-95c7eb768c5aresult-b27a1e9b-0ca1-4af3-8c00-329e135b1b20maintable\",\"source\":\"d14ca13d-e488-4f6e-a26c-95c7eb768c5a\",\"target\":\"b27a1e9b-0ca1-4af3-8c00-329e135b1b20\",\"sourceHandle\":\"result\",\"targetHandle\":\"maintable\",\"animated\":false},{\"id\":\"reactflow__edge-d14ca13d-e488-4f6e-a26c-95c7eb768c5a-1725537061002result-b27a1e9b-0ca1-4af3-8c00-329e135b1b20secondarytable\",\"source\":\"d14ca13d-e488-4f6e-a26c-95c7eb768c5a-1725537061002\",\"target\":\"b27a1e9b-0ca1-4af3-8c00-329e135b1b20\",\"sourceHandle\":\"result\",\"targetHandle\":\"secondarytable\",\"animated\":false},{\"id\":\"bafd95c7-fbef-41ad-8f89-bdaa7b463241\",\"type\":\"default\",\"source\":\"dac13ed6-cca8-403e-9594-88c3a7cb9b5a\",\"target\":\"b4ecec01-7c7c-4399-9be5-2977982f114b\",\"sourceHandle\":\"out\",\"targetHandle\":\"source\",\"animated\":false},{\"id\":\"ccd63bf4-9ec4-467d-b37b-bf5ca40f2797\",\"type\":\"default\",\"source\":\"dac13ed6-cca8-403e-9594-88c3a7cb9b5a\",\"target\":\"b4ecec01-7c7c-4399-9be5-2977982f114b-1725528351591\",\"sourceHandle\":\"out\",\"targetHandle\":\"source\",\"animated\":false}],\"variables\":null,\"procedure\":{},\"schedule\":{},\"viewport\":{\"x\":193.7137521466459,\"y\":73.47375820672482,\"zoom\":0.737689489353778},\"schemaVersion\":\"1.0.0\",\"connectionProvider\":\"bigquery\",\"useCache\":false}"}
  */
  BEGIN
  CALL `carto-un.carto`.TIME_SERIES_CLUSTERING(
    '''
    SELECT
      * EXCEPT (week), CAST(week AS DATETIME) AS week
    FROM `cartobq.sdsc24_ny_workshops.CHI_boundary_enriched`
    ''',
    'cartodb-on-gcp-datascience.workflows_temp.__temp_98c1eda6_86c2_4512_a406_5598ca09562e',
    'h3',
    'week',
    'counts',
    JSON '''
    {
      "method": "profile",
      "n_clusters": 4
    }
    '''
  );
  CREATE TEMPORARY TABLE `WORKFLOW_992fd10bed7791df_5f31dd307812edc2_result`
  AS
    SELECT * FROM `cartodb-on-gcp-datascience.workflows_temp.__temp_98c1eda6_86c2_4512_a406_5598ca09562e`;
  END;
  BEGIN
  CREATE TEMPORARY TABLE `WORKFLOW_992fd10bed7791df_591ace873ce3075a_result`
  AS
    SELECT * EXCEPT (cluster),
      cluster AS cluster_profile
    FROM `WORKFLOW_992fd10bed7791df_5f31dd307812edc2_result`;
  END;
  BEGIN
  CALL `carto-un.carto`.TIME_SERIES_CLUSTERING(
    '''
    SELECT
      * EXCEPT (week), CAST(week AS DATETIME) AS week
    FROM `cartobq.sdsc24_ny_workshops.CHI_boundary_enriched`
    ''',
    'cartodb-on-gcp-datascience.workflows_temp.__temp_dc6f65b4_6212_4566_b461_033cf40782e4',
    'h3',
    'week',
    'counts',
    JSON '''
    {
      "method": "value",
      "n_clusters": 4
    }
    '''
  );
  CREATE TEMPORARY TABLE `WORKFLOW_992fd10bed7791df_9fe2880d95752eb9_result`
  AS
    SELECT * FROM `cartodb-on-gcp-datascience.workflows_temp.__temp_dc6f65b4_6212_4566_b461_033cf40782e4`;
  END;
  BEGIN
  CREATE TEMPORARY TABLE `WORKFLOW_992fd10bed7791df_f4893d454d670412_result`
  AS
    SELECT * EXCEPT (cluster),
      cluster AS cluster_value
    FROM `WORKFLOW_992fd10bed7791df_9fe2880d95752eb9_result`;
  END;
  BEGIN
  DECLARE alias STRING;
  CREATE TABLE `cartodb-on-gcp-datascience.workflows_temp.table_9f342a82_f992_48b0_90d5_68a1858efaad` AS
  SELECT * FROM `WORKFLOW_992fd10bed7791df_591ace873ce3075a_result`
  WHERE 1=0;
  EXECUTE IMMEDIATE
  '''
    with __alias AS(
      SELECT CONCAT(
        '_joined.', column_name, ' AS ', column_name, '_joined'
      ) col_alias
      FROM `cartodb-on-gcp-datascience.workflows_temp`.INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'table_9f342a82_f992_48b0_90d5_68a1858efaad'
    )
    SELECT STRING_AGG(col_alias, ', ')
    FROM __alias
  '''
  INTO alias;
  DROP TABLE `cartodb-on-gcp-datascience.workflows_temp.table_9f342a82_f992_48b0_90d5_68a1858efaad`;
  EXECUTE IMMEDIATE
  REPLACE(
    '''CREATE TEMPORARY TABLE `WORKFLOW_992fd10bed7791df_a075dae38514b8fd_result`
    AS
      SELECT
        _main.*,
        %s
      FROM
        `WORKFLOW_992fd10bed7791df_f4893d454d670412_result` AS _main
      INNER JOIN
        `WORKFLOW_992fd10bed7791df_591ace873ce3075a_result` AS _joined
      ON
        _main.h3 = _joined.h3''',
    '%s',
    alias
  );
  END;
  BEGIN
  CREATE TEMPORARY TABLE `WORKFLOW_992fd10bed7791df_0c58c0481aee8d1c_result`
  AS
    SELECT * EXCEPT (cluster_profile_joined),
      cluster_profile_joined AS cluster_profile
    FROM `WORKFLOW_992fd10bed7791df_a075dae38514b8fd_result`;
  END;
  BEGIN
  CREATE TEMPORARY TABLE `WORKFLOW_992fd10bed7791df_516028864d33cab4_result`
  AS
    SELECT * EXCEPT (h3_joined)
    FROM `WORKFLOW_992fd10bed7791df_0c58c0481aee8d1c_result`;
  END;
  BEGIN
  DROP TABLE IF EXISTS `<my-project>.<my-dataset>.CHI_boundary_enriched_TS_clustering`;
  CREATE TABLE IF NOT EXISTS `<my-project>.<my-dataset>.CHI_boundary_enriched_TS_clustering`
  CLUSTER BY h3
  AS
    SELECT * FROM `WORKFLOW_992fd10bed7791df_516028864d33cab4_result`;
  END;
END;