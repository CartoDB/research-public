-- WARNING: This procedure requires the Analytics Toolbox and assumes it will be located
-- at the following path: carto-un.carto. If you want to deploy and
-- run it in a different location, you will need to update the code accordingly.
CREATE OR REPLACE PROCEDURE
  `cartodb-on-gcp-datascience.workflows_temp.wfproc_4fccef93e62f7626`(
)
BEGIN
  /*
   {"versionId":"f39309149a8c8fcd","paramsId":"97d170e1550eee4a","isImmutable":true,"diagramJson":"{\"tags\":[],\"edges\":[{\"id\":\"81f414d5-3ff3-4a3b-a129-95231e964517out-b4ecec01-7c7c-4399-9be5-2977982f114bsource\",\"source\":\"81f414d5-3ff3-4a3b-a129-95231e964517\",\"target\":\"b4ecec01-7c7c-4399-9be5-2977982f114b\",\"animated\":false,\"selected\":false,\"className\":\"\",\"sourceHandle\":\"out\",\"targetHandle\":\"source\"},{\"id\":\"reactflow__edge-81f414d5-3ff3-4a3b-a129-95231e964517out-b4ecec01-7c7c-4399-9be5-2977982f114b-1725528351591source\",\"source\":\"81f414d5-3ff3-4a3b-a129-95231e964517\",\"target\":\"b4ecec01-7c7c-4399-9be5-2977982f114b-1725528351591\",\"animated\":false,\"selected\":false,\"sourceHandle\":\"out\",\"targetHandle\":\"source\"},{\"id\":\"b4ecec01-7c7c-4399-9be5-2977982f114bresult-d14ca13d-e488-4f6e-a26c-95c7eb768c5asource\",\"source\":\"b4ecec01-7c7c-4399-9be5-2977982f114b\",\"target\":\"d14ca13d-e488-4f6e-a26c-95c7eb768c5a\",\"animated\":false,\"selected\":false,\"className\":\"\",\"sourceHandle\":\"result\",\"targetHandle\":\"source\"},{\"id\":\"b4ecec01-7c7c-4399-9be5-2977982f114b-1725528351591result-d14ca13d-e488-4f6e-a26c-95c7eb768c5a-1725537061002source\",\"source\":\"b4ecec01-7c7c-4399-9be5-2977982f114b-1725528351591\",\"target\":\"d14ca13d-e488-4f6e-a26c-95c7eb768c5a-1725537061002\",\"animated\":false,\"selected\":false,\"className\":\"\",\"sourceHandle\":\"result\",\"targetHandle\":\"source\"},{\"id\":\"b27a1e9b-0ca1-4af3-8c00-329e135b1b20result-425caed9-aced-4d28-a5ea-ad8789e284c4source\",\"source\":\"b27a1e9b-0ca1-4af3-8c00-329e135b1b20\",\"target\":\"425caed9-aced-4d28-a5ea-ad8789e284c4\",\"animated\":false,\"selected\":false,\"className\":\"\",\"sourceHandle\":\"result\",\"targetHandle\":\"source\"},{\"id\":\"425caed9-aced-4d28-a5ea-ad8789e284c4result-39ab3062-5255-48c5-b52d-6bbf8bb45944source\",\"source\":\"425caed9-aced-4d28-a5ea-ad8789e284c4\",\"target\":\"39ab3062-5255-48c5-b52d-6bbf8bb45944\",\"animated\":false,\"className\":\"\",\"sourceHandle\":\"result\",\"targetHandle\":\"source\"},{\"id\":\"reactflow__edge-39ab3062-5255-48c5-b52d-6bbf8bb45944result-1cb15037-ae9e-4fc1-a60f-4dc87d23eb57source\",\"source\":\"39ab3062-5255-48c5-b52d-6bbf8bb45944\",\"target\":\"1cb15037-ae9e-4fc1-a60f-4dc87d23eb57\",\"animated\":false,\"sourceHandle\":\"result\",\"targetHandle\":\"source\"},{\"id\":\"reactflow__edge-d14ca13d-e488-4f6e-a26c-95c7eb768c5aresult-b27a1e9b-0ca1-4af3-8c00-329e135b1b20maintable\",\"source\":\"d14ca13d-e488-4f6e-a26c-95c7eb768c5a\",\"target\":\"b27a1e9b-0ca1-4af3-8c00-329e135b1b20\",\"animated\":false,\"sourceHandle\":\"result\",\"targetHandle\":\"maintable\"},{\"id\":\"reactflow__edge-d14ca13d-e488-4f6e-a26c-95c7eb768c5a-1725537061002result-b27a1e9b-0ca1-4af3-8c00-329e135b1b20secondarytable\",\"source\":\"d14ca13d-e488-4f6e-a26c-95c7eb768c5a-1725537061002\",\"target\":\"b27a1e9b-0ca1-4af3-8c00-329e135b1b20\",\"animated\":false,\"sourceHandle\":\"result\",\"targetHandle\":\"secondarytable\"}],\"nodes\":[{\"id\":\"b4ecec01-7c7c-4399-9be5-2977982f114b\",\"data\":{\"name\":\"native.timeseriesclustering\",\"inputs\":[{\"name\":\"source\",\"type\":\"Table\",\"title\":\"Source table\",\"description\":\"Source table\"},{\"name\":\"partitioning_col\",\"type\":\"Column\",\"title\":\"Partition column\",\"helper\":\"Each unique value on this column will be assigned a cluster\",\"parent\":\"source\",\"dataType\":[\"string\",\"number\"],\"description\":\"Partition column\",\"value\":\"h3\",\"options\":[\"h3\",\"counts\",\"year\",\"month\",\"total_pop_sum\",\"median_age_avg\",\"median_rent_avg\",\"black_pop_sum\",\"hispanic_pop_sum\",\"owner_occupied_housing_units_median_value_sum\",\"vacant_housing_units_sum\",\"housing_units_sum\",\"families_with_young_children_sum\",\"urbanity_any\",\"urbanity_any_ordinal\",\"principal_component_1\",\"principal_component_2\"]},{\"name\":\"ts_col\",\"type\":\"Column\",\"title\":\"Timestamp column\",\"parent\":\"source\",\"dataType\":[\"datetime\",\"timestamp\",\"date\"],\"description\":\"Timestamp column\",\"value\":\"week\",\"options\":[\"week\"]},{\"name\":\"value_col\",\"type\":\"Column\",\"title\":\"Value column\",\"helper\":\"Clusters will be calculated based on the value of this column along time\",\"parent\":\"source\",\"dataType\":[\"number\"],\"description\":\"Value column\",\"value\":\"counts\",\"options\":[\"counts\",\"year\",\"month\",\"total_pop_sum\",\"median_age_avg\",\"median_rent_avg\",\"black_pop_sum\",\"hispanic_pop_sum\",\"owner_occupied_housing_units_median_value_sum\",\"vacant_housing_units_sum\",\"housing_units_sum\",\"families_with_young_children_sum\",\"urbanity_any_ordinal\",\"principal_component_1\",\"principal_component_2\"]},{\"name\":\"method\",\"type\":\"Selection\",\"title\":\"Algorithm\",\"helper\":\"Method to compare the time series\",\"options\":[\"Value\",\"Profile\"],\"description\":\"Algorithm\",\"value\":\"Value\"},{\"name\":\"n_clusters\",\"type\":\"Number\",\"title\":\"Number of clusters\",\"description\":\"Number of clusters\",\"value\":4},{\"name\":\"optimizationcol\",\"type\":\"Column\",\"title\":\"Cluster by\",\"parent\":\"source\",\"parentOutput\":\"result\",\"dataType\":[\"geography\",\"boolean\",\"number\",\"string\",\"date\",\"datetime\",\"time\",\"timestamp\"],\"providers\":[\"bigquery\"],\"optional\":true,\"advanced\":true,\"description\":\"Cluster by\",\"value\":\"h3\",\"options\":[\"h3\",\"cluster\"]}],\"version\":\"1\",\"label\":\"Cluster Time Series\"},\"type\":\"generic\",\"width\":64,\"height\":64,\"zIndex\":2,\"dragging\":false,\"position\":{\"x\":496,\"y\":272},\"selected\":false,\"positionAbsolute\":{\"x\":496,\"y\":272}},{\"id\":\"81f414d5-3ff3-4a3b-a129-95231e964517\",\"data\":{\"id\":\"cartobq.sdsc24_ny_workshops.CHI_boundary_enriched\",\"name\":\"ReadTable\",\"size\":7403165,\"type\":\"table\",\"label\":\"CHI_boundary_enriched\",\"nrows\":180565,\"inputs\":[{\"name\":\"source\",\"type\":\"String\",\"title\":\"Source table\",\"value\":\"cartobq.sdsc24_ny_workshops.CHI_boundary_enriched\",\"description\":\"Read Table\"}],\"schema\":[{\"name\":\"week\",\"type\":\"timestamp\"},{\"name\":\"h3\",\"type\":\"string\"},{\"name\":\"counts\",\"type\":\"number\"},{\"name\":\"month\",\"type\":\"number\"}],\"enriched\":true,\"provider\":\"bigquery\",\"geomField\":\"h3:h3\",\"tableRegion\":\"US\",\"lastModified\":1725460456273,\"optimization\":{\"actions\":[{\"type\":\"cluster\",\"enabled\":false}],\"actionAvailable\":{\"msg\":\"<b>This table isn't optimized.</b> Creating a cluster based on geospatial data may improve performance.\",\"type\":\"createTable\",\"query\":\"CREATE TABLE {newTableName} CLUSTER BY h3 AS SELECT * FROM `cartobq.sdsc24_ny_workshops.CHI_boundary_enriched`\"}},\"originalSchema\":[{\"name\":\"week\",\"type\":\"DATE\"},{\"name\":\"h3\",\"type\":\"STRING\"},{\"name\":\"counts\",\"type\":\"INTEGER\"},{\"name\":\"month\",\"type\":\"INTEGER\"}]},\"type\":\"source\",\"width\":192,\"height\":64,\"zIndex\":2,\"dragging\":false,\"position\":{\"x\":-48,\"y\":384},\"selected\":false,\"positionAbsolute\":{\"x\":-48,\"y\":384}},{\"id\":\"b4ecec01-7c7c-4399-9be5-2977982f114b-1725528351591\",\"data\":{\"name\":\"native.timeseriesclustering\",\"inputs\":[{\"name\":\"source\",\"type\":\"Table\",\"title\":\"Source table\",\"description\":\"Source table\"},{\"name\":\"partitioning_col\",\"type\":\"Column\",\"title\":\"Partition column\",\"helper\":\"Each unique value on this column will be assigned a cluster\",\"parent\":\"source\",\"dataType\":[\"string\",\"number\"],\"description\":\"Partition column\",\"value\":\"h3\",\"options\":[\"h3\",\"counts\",\"year\",\"month\",\"total_pop_sum\",\"median_age_avg\",\"median_rent_avg\",\"black_pop_sum\",\"hispanic_pop_sum\",\"owner_occupied_housing_units_median_value_sum\",\"vacant_housing_units_sum\",\"housing_units_sum\",\"families_with_young_children_sum\",\"urbanity_any\",\"urbanity_any_ordinal\",\"principal_component_1\",\"principal_component_2\"]},{\"name\":\"ts_col\",\"type\":\"Column\",\"title\":\"Timestamp column\",\"parent\":\"source\",\"dataType\":[\"datetime\",\"timestamp\",\"date\"],\"description\":\"Timestamp column\",\"value\":\"week\",\"options\":[\"week\"]},{\"name\":\"value_col\",\"type\":\"Column\",\"title\":\"Value column\",\"helper\":\"Clusters will be calculated based on the value of this column along time\",\"parent\":\"source\",\"dataType\":[\"number\"],\"description\":\"Value column\",\"value\":\"counts\",\"options\":[\"counts\",\"year\",\"month\",\"total_pop_sum\",\"median_age_avg\",\"median_rent_avg\",\"black_pop_sum\",\"hispanic_pop_sum\",\"owner_occupied_housing_units_median_value_sum\",\"vacant_housing_units_sum\",\"housing_units_sum\",\"families_with_young_children_sum\",\"urbanity_any_ordinal\",\"principal_component_1\",\"principal_component_2\"]},{\"name\":\"method\",\"type\":\"Selection\",\"title\":\"Algorithm\",\"helper\":\"Method to compare the time series\",\"options\":[\"Value\",\"Profile\"],\"description\":\"Algorithm\",\"value\":\"Profile\"},{\"name\":\"n_clusters\",\"type\":\"Number\",\"title\":\"Number of clusters\",\"description\":\"Number of clusters\",\"value\":4},{\"name\":\"optimizationcol\",\"type\":\"Column\",\"title\":\"Cluster by\",\"parent\":\"source\",\"parentOutput\":\"result\",\"dataType\":[\"geography\",\"boolean\",\"number\",\"string\",\"date\",\"datetime\",\"time\",\"timestamp\"],\"providers\":[\"bigquery\"],\"optional\":true,\"advanced\":true,\"description\":\"Cluster by\",\"value\":\"h3\",\"options\":[\"h3\",\"cluster\"]}],\"version\":\"1\",\"label\":\"Cluster Time Series\"},\"type\":\"generic\",\"width\":64,\"height\":64,\"zIndex\":2,\"dragging\":false,\"position\":{\"x\":496,\"y\":576},\"selected\":false,\"positionAbsolute\":{\"x\":496,\"y\":576}},{\"id\":\"d14ca13d-e488-4f6e-a26c-95c7eb768c5a\",\"data\":{\"name\":\"native.renamecolumn\",\"inputs\":[{\"name\":\"source\",\"type\":\"Table\",\"title\":\"Source table\",\"description\":\"Source table\"},{\"name\":\"column\",\"type\":\"Column\",\"title\":\"Column to rename\",\"parent\":\"source\",\"dataType\":[\"boolean\",\"geography\",\"number\",\"string\"],\"description\":\"Column to rename\",\"value\":\"cluster\",\"options\":[\"h3\",\"cluster\"]},{\"name\":\"newname\",\"type\":\"String\",\"title\":\"New column name\",\"validation\":\"^[a-zA-Z_][a-zA-Z0-9_]*$\",\"allowExpressions\":false,\"description\":\"New column name\",\"value\":\"cluster_value\"},{\"name\":\"optimizationcol\",\"type\":\"Column\",\"title\":\"Cluster by\",\"parent\":\"source\",\"parentOutput\":\"result\",\"dataType\":[\"geography\",\"boolean\",\"number\",\"string\",\"date\",\"datetime\",\"time\",\"timestamp\"],\"providers\":[\"bigquery\"],\"optional\":true,\"advanced\":true,\"description\":\"Cluster by\",\"value\":\"h3\",\"options\":[\"h3\",\"cluster_value\"]}],\"version\":\"1\",\"label\":\"Rename Column\"},\"type\":\"generic\",\"width\":64,\"height\":64,\"zIndex\":2,\"dragging\":false,\"position\":{\"x\":784,\"y\":272},\"selected\":false,\"positionAbsolute\":{\"x\":784,\"y\":272}},{\"id\":\"d14ca13d-e488-4f6e-a26c-95c7eb768c5a-1725537061002\",\"data\":{\"name\":\"native.renamecolumn\",\"inputs\":[{\"name\":\"source\",\"type\":\"Table\",\"title\":\"Source table\",\"description\":\"Source table\"},{\"name\":\"column\",\"type\":\"Column\",\"title\":\"Column to rename\",\"parent\":\"source\",\"dataType\":[\"boolean\",\"geography\",\"number\",\"string\"],\"description\":\"Column to rename\",\"value\":\"cluster\",\"options\":[\"h3\",\"cluster\"]},{\"name\":\"newname\",\"type\":\"String\",\"title\":\"New column name\",\"validation\":\"^[a-zA-Z_][a-zA-Z0-9_]*$\",\"allowExpressions\":false,\"description\":\"New column name\",\"value\":\"cluster_profile\"},{\"name\":\"optimizationcol\",\"type\":\"Column\",\"title\":\"Cluster by\",\"parent\":\"source\",\"parentOutput\":\"result\",\"dataType\":[\"geography\",\"boolean\",\"number\",\"string\",\"date\",\"datetime\",\"time\",\"timestamp\"],\"providers\":[\"bigquery\"],\"optional\":true,\"advanced\":true,\"description\":\"Cluster by\",\"value\":\"h3\",\"options\":[\"h3\",\"cluster_profile\"]}],\"version\":\"1\",\"label\":\"Rename Column\"},\"type\":\"generic\",\"width\":64,\"height\":64,\"zIndex\":2,\"dragging\":false,\"position\":{\"x\":784,\"y\":576},\"selected\":false,\"positionAbsolute\":{\"x\":784,\"y\":576}},{\"id\":\"b27a1e9b-0ca1-4af3-8c00-329e135b1b20\",\"data\":{\"name\":\"native.join\",\"inputs\":[{\"name\":\"maintable\",\"type\":\"Table\",\"title\":\"Main table\",\"description\":\"Main table\"},{\"name\":\"secondarytable\",\"type\":\"Table\",\"title\":\"Secondary table\",\"description\":\"Secondary table\"},{\"name\":\"maincolumn\",\"type\":\"Column\",\"title\":\"Column in main table\",\"parent\":\"maintable\",\"dataType\":[\"boolean\",\"date\",\"datetime\",\"time\",\"timestamp\",\"number\",\"string\"],\"description\":\"Column in main table\",\"value\":\"h3\",\"options\":[\"h3\",\"cluster_value\"]},{\"name\":\"secondarycolumn\",\"type\":\"Column\",\"title\":\"Column in secondary table\",\"parent\":\"secondarytable\",\"dataType\":[\"boolean\",\"date\",\"datetime\",\"time\",\"timestamp\",\"number\",\"string\"],\"description\":\"Column in secondary table\",\"value\":\"h3\",\"options\":[\"h3\",\"cluster_profile\"]},{\"name\":\"jointype\",\"type\":\"Selection\",\"title\":\"Join type\",\"options\":[\"Inner\",\"Left\",\"Right\",\"Full outer\"],\"default\":\"Inner\",\"description\":\"Join type\",\"value\":\"Inner\"},{\"name\":\"optimizationcol\",\"type\":\"Column\",\"title\":\"Cluster by\",\"parent\":\"source\",\"parentOutput\":\"result\",\"dataType\":[\"geography\",\"boolean\",\"number\",\"string\",\"date\",\"datetime\",\"time\",\"timestamp\"],\"providers\":[\"bigquery\"],\"optional\":true,\"advanced\":true,\"description\":\"Cluster by\"}],\"version\":\"1.2\",\"label\":\"Join\"},\"type\":\"generic\",\"width\":64,\"height\":64,\"zIndex\":2,\"dragging\":false,\"position\":{\"x\":1120,\"y\":384},\"selected\":false,\"positionAbsolute\":{\"x\":1120,\"y\":384}},{\"id\":\"1cb15037-ae9e-4fc1-a60f-4dc87d23eb57\",\"data\":{\"name\":\"native.saveastable\",\"inputs\":[{\"name\":\"source\",\"type\":\"Table\",\"title\":\"Source table\",\"description\":\"Source table\"},{\"name\":\"destination\",\"type\":\"OutputTable\",\"title\":\"Table details\",\"placeholder\":\"Rename and select destination\",\"description\":\"Table details\",\"value\":\"cartobq.sdsc24_ny_workshops.CHI_boundary_enriched_TS_clustering\"},{\"name\":\"append\",\"type\":\"Boolean\",\"title\":\"Append to existing table\",\"default\":false,\"description\":\"Append to existing table\",\"value\":false},{\"name\":\"optimizationcol\",\"type\":\"Column\",\"title\":\"Cluster by\",\"parent\":\"source\",\"parentOutput\":\"result\",\"dataType\":[\"geography\",\"boolean\",\"number\",\"string\",\"date\",\"datetime\",\"time\",\"timestamp\"],\"providers\":[\"bigquery\"],\"optional\":true,\"advanced\":true,\"description\":\"Cluster by\",\"value\":\"h3\",\"options\":[\"h3\",\"cluster_value\",\"cluster_profile\"]}],\"version\":\"1\",\"label\":\"Save as Table\"},\"type\":\"generic\",\"width\":64,\"height\":64,\"zIndex\":2,\"dragging\":true,\"position\":{\"x\":1616,\"y\":384},\"selected\":false,\"positionAbsolute\":{\"x\":1616,\"y\":384}},{\"id\":\"425caed9-aced-4d28-a5ea-ad8789e284c4\",\"data\":{\"name\":\"native.renamecolumn\",\"inputs\":[{\"name\":\"source\",\"type\":\"Table\",\"title\":\"Source table\",\"description\":\"Source table\"},{\"name\":\"column\",\"type\":\"Column\",\"title\":\"Column to rename\",\"parent\":\"source\",\"dataType\":[\"boolean\",\"geography\",\"number\",\"string\"],\"description\":\"Column to rename\",\"value\":\"cluster_profile_joined\",\"options\":[\"h3\",\"cluster_value\",\"h3_joined\",\"cluster_profile_joined\"]},{\"name\":\"newname\",\"type\":\"String\",\"title\":\"New column name\",\"validation\":\"^[a-zA-Z_][a-zA-Z0-9_]*$\",\"allowExpressions\":false,\"description\":\"New column name\",\"value\":\"cluster_profile\"},{\"name\":\"optimizationcol\",\"type\":\"Column\",\"title\":\"Cluster by\",\"parent\":\"source\",\"parentOutput\":\"result\",\"dataType\":[\"geography\",\"boolean\",\"number\",\"string\",\"date\",\"datetime\",\"time\",\"timestamp\"],\"providers\":[\"bigquery\"],\"optional\":true,\"advanced\":true,\"description\":\"Cluster by\",\"value\":\"h3\",\"options\":[\"h3\",\"cluster_value\",\"h3_joined\",\"cluster_profile\"]}],\"version\":\"1\",\"label\":\"Rename Column\"},\"type\":\"generic\",\"width\":64,\"height\":64,\"zIndex\":2,\"dragging\":false,\"position\":{\"x\":1232,\"y\":384},\"selected\":false,\"positionAbsolute\":{\"x\":1232,\"y\":384}},{\"id\":\"2fa55e66-ae2b-4b4d-a7db-f5bb9dd48e78\",\"data\":{\"name\":\"Note\",\"color\":\"#8BE0A4\",\"genAi\":false,\"label\":\"\",\"width\":463.998,\"height\":735.9929999999999,\"inputs\":[],\"markdown\":\"---\\nlabel:\\n---\\n## Input data\",\"position\":{\"x\":-432.006,\"y\":-112}},\"type\":\"note\",\"width\":464,\"height\":736,\"zIndex\":-1,\"dragging\":false,\"position\":{\"x\":-160,\"y\":-16},\"selected\":false,\"positionAbsolute\":{\"x\":-160,\"y\":-16}},{\"id\":\"2fa55e66-ae2b-4b4d-a7db-f5bb9dd48e78-1726840001203\",\"data\":{\"name\":\"Note\",\"color\":\"#F89C74\",\"genAi\":false,\"label\":\"\",\"width\":1135.99,\"height\":735.9929999999999,\"inputs\":[],\"markdown\":\"---\\nlabel:\\n---\\n## Time series clustering\\nTime series clustering is a method used to group time series data into clusters based on similarities in their temporal patterns. It aims to find natural groupings among time series, where series within the same cluster are more similar to each other than to those in other clusters.\",\"position\":{\"x\":320,\"y\":-16}},\"type\":\"note\",\"width\":1056,\"height\":736,\"zIndex\":-1,\"dragging\":false,\"position\":{\"x\":320,\"y\":-16},\"selected\":false,\"positionAbsolute\":{\"x\":320,\"y\":-16}},{\"id\":\"2fa55e66-ae2b-4b4d-a7db-f5bb9dd48e78-1726840001203-1726840018481\",\"data\":{\"name\":\"Note\",\"color\":\"#FE88B1\",\"genAi\":false,\"label\":\"\",\"width\":431.998,\"height\":735.9929999999999,\"inputs\":[],\"markdown\":\"---\\nlabel:\\n---\\n## Save results to a table\",\"position\":{\"x\":1120,\"y\":-112.001}},\"type\":\"note\",\"width\":432,\"height\":736,\"zIndex\":-1,\"dragging\":false,\"position\":{\"x\":1472,\"y\":-16},\"selected\":false,\"positionAbsolute\":{\"x\":1472,\"y\":-16}},{\"id\":\"2fa55e66-ae2b-4b4d-a7db-f5bb9dd48e78-1726840001203-1726840063570\",\"data\":{\"name\":\"Note\",\"color\":\"#F89C74\",\"genAi\":false,\"label\":\"\",\"width\":719.994,\"height\":271.999,\"inputs\":[],\"markdown\":\"---\\nlabel: By value\\n---\\nThe series is clustered based on the **step-by-step distance of its values**. One way to think of it is that the closer the signals, the closer the series will be understood to be and the higher the chance of being clustered together.\",\"position\":{\"x\":79.998,\"y\":48}},\"type\":\"note\",\"width\":720,\"height\":272,\"zIndex\":-1,\"dragging\":false,\"position\":{\"x\":352,\"y\":144},\"selected\":false,\"positionAbsolute\":{\"x\":352,\"y\":144}},{\"id\":\"2fa55e66-ae2b-4b4d-a7db-f5bb9dd48e78-1726840001203-1726840063570-1726840097338\",\"data\":{\"name\":\"Note\",\"color\":\"#F89C74\",\"genAi\":false,\"label\":\"\",\"width\":719.994,\"height\":271.999,\"inputs\":[],\"markdown\":\"---\\nlabel: By profile\\n---\\nThe series is clustered based on their **dynamics along the time span** passed. This time, the closer the correlation between two series, the higher the chance of being clustered together.\",\"position\":{\"x\":79.998,\"y\":336}},\"type\":\"note\",\"width\":720,\"height\":272,\"zIndex\":-1,\"dragging\":false,\"position\":{\"x\":352,\"y\":432},\"selected\":false,\"positionAbsolute\":{\"x\":352,\"y\":432}},{\"id\":\"7aaaed73-4edd-408a-b58c-fda6d2c05e40\",\"data\":{\"name\":\"Note\",\"color\":\"#8BE0A4\",\"genAi\":false,\"label\":\"\",\"width\":431.998,\"height\":207.996,\"inputs\":[],\"markdown\":\"---\\nlabel: Chicago boundary enriched and pre-processed (FAMD) data\\n---\\n\",\"position\":{\"x\":-588.803,\"y\":96}},\"type\":\"note\",\"width\":432,\"height\":208,\"zIndex\":-1,\"dragging\":false,\"position\":{\"x\":-144,\"y\":320},\"selected\":false,\"positionAbsolute\":{\"x\":-144,\"y\":320}},{\"id\":\"39ab3062-5255-48c5-b52d-6bbf8bb45944\",\"data\":{\"name\":\"native.dropcolumn\",\"inputs\":[{\"name\":\"source\",\"type\":\"Table\",\"title\":\"Source table\",\"description\":\"Source table\"},{\"name\":\"column\",\"type\":\"Column\",\"title\":\"Columns to drop\",\"parent\":\"source\",\"mode\":\"multiple\",\"noDefault\":true,\"description\":\"Columns to drop\",\"value\":[\"h3_joined\"],\"options\":[\"h3\",\"cluster_value\",\"h3_joined\",\"cluster_profile\"]},{\"name\":\"optimizationcol\",\"type\":\"Column\",\"title\":\"Cluster by\",\"parent\":\"source\",\"parentOutput\":\"result\",\"dataType\":[\"geography\",\"boolean\",\"number\",\"string\",\"date\",\"datetime\",\"time\",\"timestamp\"],\"providers\":[\"bigquery\"],\"optional\":true,\"advanced\":true,\"description\":\"Cluster by\",\"value\":\"h3\",\"options\":[\"h3\",\"cluster_value\",\"cluster_profile\"]}],\"version\":\"1\",\"label\":\"Drop Columns\"},\"type\":\"generic\",\"zIndex\":2,\"dragging\":false,\"position\":{\"x\":1360,\"y\":384},\"selected\":false,\"positionAbsolute\":{\"x\":1360,\"y\":384}}],\"title\":\"(5/) SDSC24 - Unlocking Smarter Property Risk Assessments with Spatio-Temporal Crime Insights and CARTO\",\"useCache\":true,\"viewport\":{\"x\":115.35801236915484,\"y\":17.662239261890818,\"zoom\":0.6381643844144764},\"description\":\"\",\"thumbnailUrl\":\"\",\"schemaVersion\":\"1.0.0\",\"connectionProvider\":\"bigquery\"}"}
  */
  DECLARE __outputtable STRING;
  DECLARE __outputtablefqn STRING;
  SET __outputtable = 'wfproc_4fccef93e62f7626_out_' || SUBSTRING(TO_HEX(MD5('')), 1, 16);
  SET __outputtablefqn = 'cartodb-on-gcp-datascience.workflows_temp.wfproc_4fccef93e62f7626_out_' || SUBSTRING(TO_HEX(MD5('')), 1, 16);
  BEGIN
    BEGIN
    CALL `carto-un.carto`.TIME_SERIES_CLUSTERING(
      '''
      SELECT 
        * EXCEPT (week),
        CAST(week AS DATETIME) AS week
      FROM `cartobq.sdsc24_ny_workshops.CHI_boundary_enriched`
      ''',
      'cartodb-on-gcp-datascience.workflows_temp.__temp_7d73d315_79a5_4c54_aa8e_956f63695ed6',
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
    CREATE TEMPORARY TABLE `WORKFLOW_4fccef93e62f7626_5f31dd307812edc2_result`
    AS
      SELECT * FROM `cartodb-on-gcp-datascience.workflows_temp.__temp_7d73d315_79a5_4c54_aa8e_956f63695ed6`;
    END;
    BEGIN
    CREATE TEMPORARY TABLE `WORKFLOW_4fccef93e62f7626_4b76f3f08fad8426_result`
    CLUSTER BY h3
    AS
      SELECT * EXCEPT (cluster),
        cluster AS cluster_profile
      FROM `WORKFLOW_4fccef93e62f7626_5f31dd307812edc2_result`;
    END;
    BEGIN
    CALL `carto-un.carto`.TIME_SERIES_CLUSTERING(
      '''
      SELECT 
        * EXCEPT (week),
        CAST(week AS DATETIME) AS week
      FROM `cartobq.sdsc24_ny_workshops.CHI_boundary_enriched`
      ''',
      'cartodb-on-gcp-datascience.workflows_temp.__temp_54d0a95b_4de3_4803_836c_ef024602bd22',
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
    CREATE TEMPORARY TABLE `WORKFLOW_4fccef93e62f7626_9fe2880d95752eb9_result`
    AS
      SELECT * FROM `cartodb-on-gcp-datascience.workflows_temp.__temp_54d0a95b_4de3_4803_836c_ef024602bd22`;
    END;
    BEGIN
    CREATE TEMPORARY TABLE `WORKFLOW_4fccef93e62f7626_a34de13f1e679650_result`
    CLUSTER BY h3
    AS
      SELECT * EXCEPT (cluster),
        cluster AS cluster_value
      FROM `WORKFLOW_4fccef93e62f7626_9fe2880d95752eb9_result`;
    END;
    BEGIN
    DECLARE alias STRING;
    CREATE TABLE `cartodb-on-gcp-datascience.workflows_temp.table_09724ad8_8190_4605_9d09_7daa57d4d6df` AS
    SELECT * FROM `WORKFLOW_4fccef93e62f7626_4b76f3f08fad8426_result`
    WHERE 1=0;
    EXECUTE IMMEDIATE
    '''
      with __alias AS(
        SELECT CONCAT(
          '_joined.', column_name, ' AS ', column_name, '_joined'
        ) col_alias
        FROM `cartodb-on-gcp-datascience.workflows_temp`.INFORMATION_SCHEMA.COLUMNS
      WHERE table_name = 'table_09724ad8_8190_4605_9d09_7daa57d4d6df'
      )
      SELECT STRING_AGG(col_alias, ', ')
      FROM __alias
    '''
    INTO alias;
    DROP TABLE `cartodb-on-gcp-datascience.workflows_temp.table_09724ad8_8190_4605_9d09_7daa57d4d6df`;
    EXECUTE IMMEDIATE
    REPLACE(
      '''CREATE TEMPORARY TABLE `WORKFLOW_4fccef93e62f7626_aa764635c9ae3a15_result`
      AS
        SELECT
          _main.*,
          %s
        FROM
          `WORKFLOW_4fccef93e62f7626_a34de13f1e679650_result` AS _main
          INNER JOIN
          `WORKFLOW_4fccef93e62f7626_4b76f3f08fad8426_result` AS _joined
        ON
          _main.h3 = _joined.h3''',
      '%s',
      alias
    );
    END;
    BEGIN
    CREATE TEMPORARY TABLE `WORKFLOW_4fccef93e62f7626_ebef856e9b6bd8bf_result`
    CLUSTER BY h3
    AS
      SELECT * EXCEPT (cluster_profile_joined),
        cluster_profile_joined AS cluster_profile
      FROM `WORKFLOW_4fccef93e62f7626_aa764635c9ae3a15_result`;
    END;
    BEGIN
    CREATE TEMPORARY TABLE `WORKFLOW_4fccef93e62f7626_af1fa64a7e29df81_result`
    CLUSTER BY h3
    AS
      SELECT * EXCEPT (h3_joined)
      FROM `WORKFLOW_4fccef93e62f7626_ebef856e9b6bd8bf_result`;
    END;
    BEGIN
    DROP TABLE IF EXISTS `cartobq.sdsc24_ny_workshops.CHI_boundary_enriched_TS_clustering`;
    CREATE TABLE IF NOT EXISTS `cartobq.sdsc24_ny_workshops.CHI_boundary_enriched_TS_clustering`
    CLUSTER BY h3
    AS
      SELECT * FROM `WORKFLOW_4fccef93e62f7626_af1fa64a7e29df81_result`;
    END;
    EXECUTE IMMEDIATE
      '''DROP TABLE IF EXISTS `''' || __outputtablefqn || '''`'''
    ;
    EXECUTE IMMEDIATE
      '''
      CREATE TABLE `''' || __outputtablefqn || '''`
      OPTIONS (
        expiration_timestamp = TIMESTAMP_ADD(
          CURRENT_TIMESTAMP(), INTERVAL 30 DAY
        )
      )
      AS
        SELECT 1 as dummy'''
    ;
  END;
END;