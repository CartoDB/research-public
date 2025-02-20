-- WARNING: This procedure requires the Analytics Toolbox and assumes it will be located
-- at the following path: carto-un.carto. If you want to deploy and
-- run it in a different location, you will need to update the code accordingly.
CREATE OR REPLACE PROCEDURE
  `cartodb-on-gcp-datascience.workflows_temp.wfproc_5536591692e166fc`(
)
BEGIN
  /*
   {"versionId":"be2df4e37eed2d03","paramsId":"97d170e1550eee4a","isImmutable":false,"diagramJson":"{\"title\":\"(6/) GeoPython25 - Unlocking Smarter Property Risk Assessments with Spatio-Temporal Crime Insights and CARTO\",\"description\":\"\",\"nodes\":[{\"id\":\"bfaaf5ff-b74e-43fd-8e50-5c4b52144bb7\",\"data\":{\"name\":\"native.h3kring\",\"label\":\"H3 KRing\",\"title\":\"\",\"inputs\":[{\"name\":\"source\",\"type\":\"Table\",\"title\":\"Source table\",\"description\":\"Source table\"},{\"name\":\"h3\",\"type\":\"Column\",\"title\":\"H3 index column\",\"parent\":\"source\",\"dataType\":[\"string\"],\"description\":\"H3 index column\",\"value\":\"h3\"},{\"name\":\"size\",\"type\":\"Number\",\"title\":\"Size\",\"min\":1,\"default\":1,\"mode\":\"slider\",\"description\":\"Size\",\"value\":2},{\"name\":\"includecols\",\"type\":\"Boolean\",\"title\":\"Keep input table columns\",\"default\":true,\"description\":\"Keep input table columns\",\"value\":true},{\"name\":\"includedistance\",\"type\":\"Boolean\",\"title\":\"Include KRing distance column\",\"default\":true,\"description\":\"Include KRing distance column\",\"value\":true},{\"name\":\"optimizationcol\",\"value\":\"kring_index\"}],\"version\":\"1\"},\"type\":\"generic\",\"width\":64,\"height\":64,\"zIndex\":2,\"dragging\":false,\"position\":{\"x\":544,\"y\":352},\"selected\":false,\"positionAbsolute\":{\"x\":448,\"y\":368}},{\"id\":\"72e9de9d-fd56-4bff-af57-25be39504475\",\"data\":{\"name\":\"native.select\",\"label\":\"Select\",\"inputs\":[{\"name\":\"table\",\"type\":\"Table\",\"title\":\"Source table\",\"optional\":true,\"description\":\"Source table\"},{\"name\":\"select\",\"type\":\"StringSql\",\"title\":\"SELECT statement\",\"placeholder\":\"E.g.: *, distance_in_km * 1000 AS distance_in_meters\",\"allowExpressions\":false,\"description\":\"SELECT statement\",\"value\":\"h3, week\"},{\"name\":\"optimizationcol\"}],\"version\":\"1\"},\"type\":\"generic\",\"width\":64,\"height\":64,\"zIndex\":2,\"dragging\":false,\"position\":{\"x\":448,\"y\":352},\"selected\":false,\"positionAbsolute\":{\"x\":304,\"y\":368}},{\"id\":\"aab11907-275a-466c-a101-62f17f781af6\",\"data\":{\"name\":\"native.customsql\",\"label\":\"Custom SQL Select\",\"title\":\"JOIN KRing WITH EACH H3 CELL\",\"inputs\":[{\"name\":\"sourcea\",\"type\":\"Table\",\"title\":\"Source table a\",\"optional\":true,\"description\":\"Source table a\"},{\"name\":\"sourceb\",\"type\":\"Table\",\"title\":\"Source table b\",\"optional\":true,\"description\":\"Source table b\"},{\"name\":\"sourcec\",\"type\":\"Table\",\"title\":\"Source table c\",\"optional\":true,\"description\":\"Source table c\"},{\"name\":\"sql\",\"type\":\"StringSql\",\"title\":\"SQL SELECT statement\",\"mode\":\"multiline\",\"placeholder\":\"SELECT ST_Centroid(geom) AS geom,\\n  AVG(value) AS average_value,\\n  category\\nFROM $a\\nGROUP BY category\",\"allowExpressions\":false,\"description\":\"SQL SELECT statement\",\"value\":\"SELECT b.*, a.counts, a.total_pop_sum\\nFROM `$a` a\\nJOIN `$b` b\\nON a.h3 = b.kring_index AND a.week = b.week\"},{\"name\":\"optimizationcol\"}],\"version\":\"2.0.0\"},\"type\":\"generic\",\"width\":64,\"height\":64,\"zIndex\":2,\"dragging\":false,\"position\":{\"x\":736,\"y\":272},\"selected\":false,\"positionAbsolute\":{\"x\":656,\"y\":320}},{\"id\":\"99f3a883-c62f-4258-bb35-236345f3fe4f\",\"data\":{\"name\":\"native.customsql\",\"label\":\"Custom SQL Select\",\"title\":\"COMPUTE THE KRing SUM \",\"inputs\":[{\"name\":\"sourcea\",\"type\":\"Table\",\"title\":\"Source table a\",\"optional\":true,\"description\":\"Source table a\"},{\"name\":\"sourceb\",\"type\":\"Table\",\"title\":\"Source table b\",\"optional\":true,\"description\":\"Source table b\"},{\"name\":\"sourcec\",\"type\":\"Table\",\"title\":\"Source table c\",\"optional\":true,\"description\":\"Source table c\"},{\"name\":\"sql\",\"type\":\"StringSql\",\"title\":\"SQL SELECT statement\",\"mode\":\"multiline\",\"placeholder\":\"SELECT ST_Centroid(geom) AS geom,\\n  AVG(value) AS average_value,\\n  category\\nFROM $a\\nGROUP BY category\",\"allowExpressions\":false,\"description\":\"SQL SELECT statement\",\"value\":\"SELECT h3, week, \\nSUM(counts/total_pop_sum) * 1000 AS counts_ratio_kring2\\nFROM `$a`\\nWHERE total_pop_sum > 0\\nGROUP BY week, h3\\n\"},{\"name\":\"optimizationcol\"}],\"version\":\"2.0.0\"},\"type\":\"generic\",\"width\":64,\"height\":64,\"zIndex\":2,\"dragging\":false,\"position\":{\"x\":928,\"y\":272},\"selected\":false,\"positionAbsolute\":{\"x\":880,\"y\":288}},{\"id\":\"45eaec8e-83f6-4c42-b4f2-b53c675a6c60\",\"data\":{\"name\":\"native.customsql\",\"label\":\"Custom SQL Select\",\"title\":\"JOIN\",\"inputs\":[{\"name\":\"sourcea\",\"type\":\"Table\",\"title\":\"Source table a\",\"optional\":true,\"description\":\"Source table a\"},{\"name\":\"sourceb\",\"type\":\"Table\",\"title\":\"Source table b\",\"optional\":true,\"description\":\"Source table b\"},{\"name\":\"sourcec\",\"type\":\"Table\",\"title\":\"Source table c\",\"optional\":true,\"description\":\"Source table c\"},{\"name\":\"sql\",\"type\":\"StringSql\",\"title\":\"SQL SELECT statement\",\"mode\":\"multiline\",\"placeholder\":\"SELECT ST_Centroid(geom) AS geom,\\n  AVG(value) AS average_value,\\n  category\\nFROM $a\\nGROUP BY category\",\"allowExpressions\":false,\"description\":\"SQL SELECT statement\",\"value\":\"SELECT a.*,\\nCASE WHEN a.total_pop_sum > 0 THEN a.counts/a.total_pop_sum * 1000 ELSE 0 END AS counts_ratio,\\nb.counts_ratio_kring2\\nFROM `$a` a\\nJOIN `$b` b\\nON a.h3 = b.h3 AND a.week = b.week\"},{\"name\":\"optimizationcol\"}],\"version\":\"2.0.0\"},\"type\":\"generic\",\"width\":64,\"height\":64,\"zIndex\":2,\"dragging\":false,\"position\":{\"x\":1040,\"y\":208},\"selected\":false,\"positionAbsolute\":{\"x\":1040,\"y\":240}},{\"id\":\"f205bded-2345-4729-902e-bf330725e481\",\"data\":{\"name\":\"Note\",\"color\":\"#8BE0A4\",\"genAi\":false,\"label\":\"\",\"width\":495.995,\"height\":687.999,\"inputs\":[],\"markdown\":\"---\\nlabel:\\n---\\n## Input data\",\"position\":{\"x\":-256,\"y\":-64}},\"type\":\"note\",\"width\":496,\"height\":736,\"zIndex\":-1,\"dragging\":false,\"position\":{\"x\":-144,\"y\":-64},\"selected\":false,\"positionAbsolute\":{\"x\":-256,\"y\":-64}},{\"id\":\"f205bded-2345-4729-902e-bf330725e481-1726562570932\",\"data\":{\"name\":\"Note\",\"color\":\"#F89C74\",\"genAi\":false,\"label\":\"\",\"width\":816,\"height\":687.9970000000001,\"inputs\":[],\"markdown\":\"---\\nlabel:\\n---\\n## Create spatial lag variable\\nWe can add spatial-lag variables to account for the influence of neighboring or nearby regions on the variable of interest in a given location. They are derived from the idea that outcomes in one location might not be independent but influenced by outcomes in other nearby locations due to spatial interactions or spillover effects.\\n\\n<img src=\\\"https://storage.cloud.google.com/sdsc_workshops/sdsc24_10/workflows_images/Spatial_lag_var.png\\\" alt=\\\"Spatial lag\\\" width=\\\"100\\\" height=\\\"50\\\">\",\"position\":{\"x\":368,\"y\":-64}},\"type\":\"note\",\"width\":928,\"height\":736,\"zIndex\":-1,\"dragging\":false,\"position\":{\"x\":368,\"y\":-64},\"selected\":false,\"positionAbsolute\":{\"x\":256,\"y\":-64}},{\"id\":\"88f3cf30-d968-4a19-8c11-b7f76256a4e1\",\"data\":{\"name\":\"native.customsql\",\"label\":\"Custom SQL Select\",\"title\":\"ADD TEMPORAL LAGS\",\"inputs\":[{\"name\":\"sourcea\",\"type\":\"Table\",\"title\":\"Source table a\",\"optional\":true,\"description\":\"Source table a\"},{\"name\":\"sourceb\",\"type\":\"Table\",\"title\":\"Source table b\",\"optional\":true,\"description\":\"Source table b\"},{\"name\":\"sourcec\",\"type\":\"Table\",\"title\":\"Source table c\",\"optional\":true,\"description\":\"Source table c\"},{\"name\":\"sql\",\"type\":\"StringSql\",\"title\":\"SQL SELECT statement\",\"mode\":\"multiline\",\"placeholder\":\"SELECT ST_Centroid(geom) AS geom,\\n  AVG(value) AS average_value,\\n  category\\nFROM $a\\nGROUP BY category\",\"allowExpressions\":false,\"description\":\"SQL SELECT statement\",\"value\":\"SELECT *,\\nLAG(counts_ratio, 1) OVER (PARTITION BY h3 ORDER BY week) AS counts_ratio_lag_1,\\nLAG(counts_ratio, 2) OVER (PARTITION BY h3 ORDER BY week) AS counts_ratio_lag_2,\\nLAG(counts_ratio, 3) OVER (PARTITION BY h3 ORDER BY week) AS counts_ratio_lag_3\\nFROM `$a`\\n\"},{\"name\":\"optimizationcol\"}],\"version\":\"2.0.0\"},\"type\":\"generic\",\"width\":64,\"height\":64,\"zIndex\":2,\"dragging\":false,\"position\":{\"x\":1312,\"y\":336},\"selected\":false,\"positionAbsolute\":{\"x\":1376,\"y\":368}},{\"id\":\"88f3cf30-d968-4a19-8c11-b7f76256a4e1-1726562748696\",\"data\":{\"name\":\"native.customsql\",\"label\":\"Custom SQL Select\",\"title\":\"ADD SEASONAL TERMS\",\"inputs\":[{\"name\":\"sourcea\",\"type\":\"Table\",\"title\":\"Source table a\",\"optional\":true,\"description\":\"Source table a\"},{\"name\":\"sourceb\",\"type\":\"Table\",\"title\":\"Source table b\",\"optional\":true,\"description\":\"Source table b\"},{\"name\":\"sourcec\",\"type\":\"Table\",\"title\":\"Source table c\",\"optional\":true,\"description\":\"Source table c\"},{\"name\":\"sql\",\"type\":\"StringSql\",\"title\":\"SQL SELECT statement\",\"mode\":\"multiline\",\"placeholder\":\"SELECT ST_Centroid(geom) AS geom,\\n  AVG(value) AS average_value,\\n  category\\nFROM $a\\nGROUP BY category\",\"allowExpressions\":false,\"description\":\"SQL SELECT statement\",\"value\":\"SELECT *,\\nSIN(2 * ACOS(-1) * MONTH / 12) AS seasonal_sin,\\nCOS(2 * ACOS(-1) * MONTH / 12) AS seasonal_cos\\nFROM `$a`\\n\"},{\"name\":\"optimizationcol\"}],\"version\":\"2.0.0\"},\"type\":\"generic\",\"width\":64,\"height\":64,\"zIndex\":2,\"dragging\":false,\"position\":{\"x\":1504,\"y\":336},\"selected\":false,\"positionAbsolute\":{\"x\":1600,\"y\":384}},{\"id\":\"a7c19694-9a93-4059-a569-3253bff0f2f5\",\"data\":{\"name\":\"Note\",\"color\":\"#9EB9F3\",\"genAi\":false,\"label\":\"\",\"width\":848,\"height\":687.995,\"inputs\":[],\"markdown\":\"---\\nlabel:\\n---\\n## Add temporal lags and seasonal terms\\n\\n- **Temporal lag variables** are used in time series analysis to account for the effect of past values of a variable on its current or future values. Temporal lags capture the relationship between a variable at one point in time and its previous observations, helping model delayed effects or persistence over time (a.k.a. autocorrelation)\\n\\n- **Seasonal terms** can be added to model repeating seasonal behaviors. These can be represented as Fourier terms, i.e. as a periodic function by summing sine and cosine functions of different frequencies.\\n\\n\\n![Fourier](https://storage.cloud.google.com/sdsc_workshops/sdsc24_10/workflows_images/Fourier_term.png)\\n\\n\",\"position\":{\"x\":1200,\"y\":-64}},\"type\":\"note\",\"width\":1136,\"height\":736,\"zIndex\":-1,\"dragging\":false,\"position\":{\"x\":1200,\"y\":-64},\"selected\":false,\"positionAbsolute\":{\"x\":1200,\"y\":-64}},{\"id\":\"acb5859d-3ddb-4336-82eb-e7a0cd7a7eee\",\"data\":{\"name\":\"native.customsql\",\"label\":\"Custom SQL Select\",\"title\":\"US Public Holidays\",\"inputs\":[{\"name\":\"sourcea\",\"type\":\"Table\",\"title\":\"Source table a\",\"optional\":true,\"description\":\"Source table a\"},{\"name\":\"sourceb\",\"type\":\"Table\",\"title\":\"Source table b\",\"optional\":true,\"description\":\"Source table b\"},{\"name\":\"sourcec\",\"type\":\"Table\",\"title\":\"Source table c\",\"optional\":true,\"description\":\"Source table c\"},{\"name\":\"sql\",\"type\":\"StringSql\",\"title\":\"SQL SELECT statement\",\"mode\":\"multiline\",\"placeholder\":\"SELECT ST_Centroid(geom) AS geom,\\n  AVG(value) AS average_value,\\n  category\\nFROM $a\\nGROUP BY category\",\"allowExpressions\":false,\"description\":\"SQL SELECT statement\",\"value\":\"SELECT 'US' AS region,\\nDATE_TRUNC(primary_date, WEEK(MONDAY)) AS week,\\nholiday_name\\nFROM `bigquery-public-data.ml_datasets.holidays_and_events_for_forecasting`\\nWHERE region = 'US'\"},{\"name\":\"optimizationcol\"}],\"version\":\"2.0.0\"},\"type\":\"generic\",\"width\":64,\"height\":64,\"zIndex\":2,\"dragging\":false,\"position\":{\"x\":64,\"y\":432},\"selected\":false,\"positionAbsolute\":{\"x\":-64,\"y\":512}},{\"id\":\"58771a3b-dcbe-4819-bd6d-d88b333121c5\",\"data\":{\"name\":\"native.join\",\"label\":\"Join\",\"title\":\"\",\"inputs\":[{\"name\":\"maintable\",\"type\":\"Table\",\"title\":\"Main table\",\"description\":\"Main table\"},{\"name\":\"secondarytable\",\"type\":\"Table\",\"title\":\"Secondary table\",\"description\":\"Secondary table\"},{\"name\":\"maincolumn\",\"type\":\"Column\",\"title\":\"Column in main table\",\"parent\":\"maintable\",\"dataType\":[\"boolean\",\"date\",\"datetime\",\"time\",\"timestamp\",\"number\",\"string\"],\"description\":\"Column in main table\",\"value\":\"week\"},{\"name\":\"secondarycolumn\",\"type\":\"Column\",\"title\":\"Column in secondary table\",\"parent\":\"secondarytable\",\"dataType\":[\"boolean\",\"date\",\"datetime\",\"time\",\"timestamp\",\"number\",\"string\"],\"description\":\"Column in secondary table\",\"value\":\"week\"},{\"name\":\"jointype\",\"type\":\"Selection\",\"title\":\"Join type\",\"options\":[\"Inner\",\"Left\",\"Right\",\"Full outer\"],\"default\":\"Inner\",\"description\":\"Join type\",\"value\":\"Left\"},{\"name\":\"optimizationcol\"}],\"version\":\"1.2\"},\"type\":\"generic\",\"width\":64,\"height\":64,\"zIndex\":2,\"dragging\":false,\"position\":{\"x\":1696,\"y\":400},\"selected\":false,\"positionAbsolute\":{\"x\":1920,\"y\":352}},{\"id\":\"1088be6d-95df-423e-9310-d3a4d50106b7\",\"data\":{\"name\":\"native.renamecolumn\",\"label\":\"Rename Column\",\"inputs\":[{\"name\":\"source\",\"type\":\"Table\",\"title\":\"Source table\",\"description\":\"Source table\"},{\"name\":\"column\",\"type\":\"Column\",\"title\":\"Column to rename\",\"parent\":\"source\",\"dataType\":[\"boolean\",\"geography\",\"number\",\"string\"],\"description\":\"Column to rename\",\"value\":\"holiday_name_joined\"},{\"name\":\"newname\",\"type\":\"String\",\"title\":\"New column name\",\"validation\":\"^[a-zA-Z_][a-zA-Z0-9_]*$\",\"allowExpressions\":false,\"description\":\"New column name\",\"value\":\"holiday_name\"},{\"name\":\"optimizationcol\",\"value\":\"h3\"}],\"version\":\"1\"},\"type\":\"generic\",\"width\":64,\"height\":64,\"zIndex\":2,\"dragging\":false,\"position\":{\"x\":1808,\"y\":400},\"selected\":false,\"positionAbsolute\":{\"x\":2048,\"y\":352}},{\"id\":\"a6239dad-2039-4079-81f1-0ebc6a96248d\",\"data\":{\"name\":\"native.saveastable\",\"label\":\"Save as Table\",\"inputs\":[{\"name\":\"source\",\"type\":\"Table\",\"title\":\"Source table\",\"description\":\"Source table\"},{\"name\":\"destination\",\"type\":\"OutputTable\",\"title\":\"Table details\",\"placeholder\":\"Rename and select destination\",\"description\":\"Table details\",\"value\":\"<my-project>.<my-dataset>.CHI_boundary_enriched_w_lags\"},{\"name\":\"append\",\"type\":\"Boolean\",\"title\":\"Append to existing table\",\"default\":false,\"description\":\"Append to existing table\",\"value\":false},{\"name\":\"optimizationcol\",\"type\":\"Column\",\"title\":\"Cluster by\",\"parent\":\"source\",\"dataType\":[\"geography\",\"boolean\",\"number\",\"string\",\"date\",\"datetime\",\"time\",\"timestamp\"],\"providers\":[\"bigquery\"],\"optional\":true,\"advanced\":true,\"description\":\"Cluster by\",\"value\":\"h3\"}],\"version\":\"1\"},\"type\":\"generic\",\"width\":64,\"height\":64,\"zIndex\":2,\"dragging\":false,\"position\":{\"x\":2208,\"y\":288},\"selected\":false,\"positionAbsolute\":{\"x\":2544,\"y\":352}},{\"id\":\"a7c19694-9a93-4059-a569-3253bff0f2f5-1726578426527-1726578437332\",\"data\":{\"name\":\"Note\",\"color\":\"#FE88B1\",\"genAi\":false,\"label\":\"\",\"width\":336,\"height\":688,\"inputs\":[],\"markdown\":\"---\\nlabel:\\n---\\n## Save results to a table\",\"position\":{\"x\":2064,\"y\":-64}},\"type\":\"note\",\"width\":528,\"height\":736,\"zIndex\":-1,\"dragging\":true,\"position\":{\"x\":2064,\"y\":-64},\"selected\":false,\"positionAbsolute\":{\"x\":2352,\"y\":-64}},{\"id\":\"0197a4ab-452a-4a13-86f9-73d70d178c38\",\"data\":{\"name\":\"native.groupby\",\"label\":\"Group by\",\"inputs\":[{\"name\":\"source\",\"type\":\"Table\",\"title\":\"Source table\",\"description\":\"Source table\"},{\"name\":\"columns\",\"type\":\"SelectColumnAggregation\",\"title\":\"Aggregation\",\"parent\":\"source\",\"placeholder\":\"workflows.parameterForm.selectAField\",\"allowExpression\":false,\"description\":\"Aggregation\",\"value\":\"holiday_name,concat,region,any\"},{\"name\":\"groupby\",\"type\":\"Column\",\"title\":\"Group by\",\"parent\":\"source\",\"mode\":\"multiple\",\"dataType\":[\"boolean\",\"number\",\"string\",\"date\",\"datetime\",\"time\",\"timestamp\"],\"noDefault\":true,\"maxSelectionsCount\":null,\"description\":\"Group by\",\"value\":[\"week\"]},{\"name\":\"optimizationcol\"}],\"version\":\"1\"},\"type\":\"generic\",\"width\":64,\"height\":64,\"zIndex\":2,\"dragging\":false,\"position\":{\"x\":1280,\"y\":464},\"selected\":false,\"positionAbsolute\":{\"x\":1296,\"y\":512}},{\"id\":\"0e302f19-01d3-4b43-a003-0550b2f8ee78\",\"data\":{\"name\":\"native.renamecolumn\",\"label\":\"Rename Column\",\"inputs\":[{\"name\":\"source\",\"type\":\"Table\",\"title\":\"Source table\",\"description\":\"Source table\"},{\"name\":\"column\",\"type\":\"Column\",\"title\":\"Column to rename\",\"parent\":\"source\",\"dataType\":[\"boolean\",\"geography\",\"number\",\"string\"],\"description\":\"Column to rename\",\"value\":\"region_any\"},{\"name\":\"newname\",\"type\":\"String\",\"title\":\"New column name\",\"validation\":\"^[a-zA-Z_][a-zA-Z0-9_]*$\",\"allowExpressions\":false,\"description\":\"New column name\",\"value\":\"region\"},{\"name\":\"optimizationcol\"}],\"version\":\"1\"},\"type\":\"generic\",\"width\":64,\"height\":64,\"zIndex\":2,\"dragging\":false,\"position\":{\"x\":1408,\"y\":464},\"selected\":false,\"positionAbsolute\":{\"x\":1440,\"y\":512}},{\"id\":\"378b3189-8c1f-4190-91b5-3827596edeed\",\"data\":{\"name\":\"native.renamecolumn\",\"label\":\"Rename Column\",\"inputs\":[{\"name\":\"source\",\"type\":\"Table\",\"title\":\"Source table\",\"description\":\"Source table\"},{\"name\":\"column\",\"type\":\"Column\",\"title\":\"Column to rename\",\"parent\":\"source\",\"dataType\":[\"boolean\",\"geography\",\"number\",\"string\"],\"description\":\"Column to rename\",\"value\":\"holiday_name_concat\"},{\"name\":\"newname\",\"type\":\"String\",\"title\":\"New column name\",\"validation\":\"^[a-zA-Z_][a-zA-Z0-9_]*$\",\"allowExpressions\":false,\"description\":\"New column name\",\"value\":\"holiday_name\"},{\"name\":\"optimizationcol\"}],\"version\":\"1\"},\"type\":\"generic\",\"width\":64,\"height\":64,\"zIndex\":2,\"dragging\":false,\"position\":{\"x\":1552,\"y\":464},\"selected\":false,\"positionAbsolute\":{\"x\":1600,\"y\":512}},{\"id\":\"9504b68e-364d-4c07-be20-4ac26b174f35\",\"data\":{\"name\":\"native.dropcolumn\",\"label\":\"Drop Columns\",\"inputs\":[{\"name\":\"source\",\"type\":\"Table\",\"title\":\"Source table\",\"description\":\"Source table\"},{\"name\":\"column\",\"type\":\"Column\",\"title\":\"Columns to drop\",\"parent\":\"source\",\"mode\":\"multiple\",\"noDefault\":true,\"description\":\"Columns to drop\",\"value\":[\"week_joined\",\"region_joined\"]},{\"name\":\"optimizationcol\",\"value\":\"h3\"}],\"version\":\"1\"},\"type\":\"generic\",\"width\":64,\"height\":64,\"zIndex\":2,\"dragging\":false,\"position\":{\"x\":1920,\"y\":400},\"selected\":false,\"positionAbsolute\":{\"x\":2192,\"y\":352}},{\"id\":\"f205bded-2345-4729-902e-bf330725e481-1727095541216\",\"data\":{\"name\":\"Note\",\"color\":\"#8BE0A4\",\"genAi\":false,\"label\":\"\",\"width\":431.995,\"height\":239.999,\"inputs\":[],\"markdown\":\"---\\nlabel: Chicago boundary enriched and pre-processed (FAMD) data\\n---\\n\",\"position\":{\"x\":-112.001,\"y\":80}},\"type\":\"note\",\"width\":448,\"height\":240,\"zIndex\":-1,\"dragging\":false,\"position\":{\"x\":-128,\"y\":80},\"selected\":false,\"positionAbsolute\":{\"x\":-224,\"y\":80}},{\"id\":\"f205bded-2345-4729-902e-bf330725e481-1727095541216-1727095696989\",\"data\":{\"name\":\"Note\",\"color\":\"#8BE0A4\",\"genAi\":false,\"label\":\"\",\"width\":431.995,\"height\":239.999,\"inputs\":[],\"markdown\":\"---\\nlabel: Public Holidays dataset from BigQuery ML datasets\\n---\\n\",\"position\":{\"x\":-112.001,\"y\":352}},\"type\":\"note\",\"width\":448,\"height\":240,\"zIndex\":-1,\"dragging\":false,\"position\":{\"x\":-128,\"y\":352},\"selected\":false,\"positionAbsolute\":{\"x\":-224,\"y\":400}},{\"id\":\"f63d9b1c-20c0-4215-bafa-4760f8ef1061\",\"data\":{\"id\":\"cartobq.sdsc24_ny_workshops.CHI_boundary_enriched\",\"name\":\"ReadTable\",\"size\":24120250,\"type\":\"table\",\"label\":\"CHI_boundary_enriched\",\"nrows\":145348,\"inputs\":[{\"name\":\"source\",\"type\":\"String\",\"title\":\"Source table\",\"value\":\"cartobq.sdsc24_ny_workshops.CHI_boundary_enriched\",\"description\":\"Read Table\"}],\"schema\":[{\"name\":\"week\",\"type\":\"timestamp\"},{\"name\":\"h3\",\"type\":\"string\"},{\"name\":\"counts\",\"type\":\"number\"},{\"name\":\"year\",\"type\":\"number\"},{\"name\":\"month\",\"type\":\"number\"},{\"name\":\"total_pop_sum\",\"type\":\"number\"},{\"name\":\"median_age_avg\",\"type\":\"number\"},{\"name\":\"median_rent_avg\",\"type\":\"number\"},{\"name\":\"black_pop_sum\",\"type\":\"number\"},{\"name\":\"hispanic_pop_sum\",\"type\":\"number\"},{\"name\":\"owner_occupied_housing_units_median_value_sum\",\"type\":\"number\"},{\"name\":\"vacant_housing_units_sum\",\"type\":\"number\"},{\"name\":\"housing_units_sum\",\"type\":\"number\"},{\"name\":\"families_with_young_children_sum\",\"type\":\"number\"},{\"name\":\"urbanity_any\",\"type\":\"string\"},{\"name\":\"urbanity_any_ordinal\",\"type\":\"number\"},{\"name\":\"principal_component_1\",\"type\":\"number\"},{\"name\":\"principal_component_2\",\"type\":\"number\"}],\"enriched\":true,\"provider\":\"bigquery\",\"geomField\":\"h3:h3\",\"tableRegion\":\"US\",\"lastModified\":1739890156229,\"optimization\":{\"actions\":[{\"type\":\"cluster\",\"enabled\":false}],\"actionAvailable\":{\"msg\":\"<b>This table isn't optimized.</b> Creating a cluster based on geospatial data may improve performance.\",\"type\":\"createTable\",\"query\":\"CREATE TABLE {newTableName} CLUSTER BY h3 AS SELECT * FROM `cartobq.sdsc24_ny_workshops.CHI_boundary_enriched`\"}},\"originalSchema\":[{\"name\":\"week\",\"type\":\"DATE\"},{\"name\":\"h3\",\"type\":\"STRING\"},{\"name\":\"counts\",\"type\":\"INTEGER\"},{\"name\":\"year\",\"type\":\"INTEGER\"},{\"name\":\"month\",\"type\":\"INTEGER\"},{\"name\":\"total_pop_sum\",\"type\":\"FLOAT\"},{\"name\":\"median_age_avg\",\"type\":\"FLOAT\"},{\"name\":\"median_rent_avg\",\"type\":\"FLOAT\"},{\"name\":\"black_pop_sum\",\"type\":\"FLOAT\"},{\"name\":\"hispanic_pop_sum\",\"type\":\"FLOAT\"},{\"name\":\"owner_occupied_housing_units_median_value_sum\",\"type\":\"FLOAT\"},{\"name\":\"vacant_housing_units_sum\",\"type\":\"FLOAT\"},{\"name\":\"housing_units_sum\",\"type\":\"FLOAT\"},{\"name\":\"families_with_young_children_sum\",\"type\":\"FLOAT\"},{\"name\":\"urbanity_any\",\"type\":\"STRING\"},{\"name\":\"urbanity_any_ordinal\",\"type\":\"INTEGER\"},{\"name\":\"principal_component_1\",\"type\":\"FLOAT\"},{\"name\":\"principal_component_2\",\"type\":\"FLOAT\"}]},\"type\":\"source\",\"zIndex\":2,\"position\":{\"x\":0,\"y\":160},\"selected\":false}],\"edges\":[{\"id\":\"reactflow__edge-72e9de9d-fd56-4bff-af57-25be39504475result-bfaaf5ff-b74e-43fd-8e50-5c4b52144bb7source\",\"source\":\"72e9de9d-fd56-4bff-af57-25be39504475\",\"target\":\"bfaaf5ff-b74e-43fd-8e50-5c4b52144bb7\",\"selected\":false,\"sourceHandle\":\"result\",\"targetHandle\":\"source\",\"animated\":false},{\"id\":\"reactflow__edge-bfaaf5ff-b74e-43fd-8e50-5c4b52144bb7result-aab11907-275a-466c-a101-62f17f781af6sourceb\",\"source\":\"bfaaf5ff-b74e-43fd-8e50-5c4b52144bb7\",\"target\":\"aab11907-275a-466c-a101-62f17f781af6\",\"selected\":false,\"sourceHandle\":\"result\",\"targetHandle\":\"sourceb\",\"animated\":false},{\"id\":\"reactflow__edge-aab11907-275a-466c-a101-62f17f781af6result-99f3a883-c62f-4258-bb35-236345f3fe4fsourcea\",\"source\":\"aab11907-275a-466c-a101-62f17f781af6\",\"target\":\"99f3a883-c62f-4258-bb35-236345f3fe4f\",\"selected\":false,\"sourceHandle\":\"result\",\"targetHandle\":\"sourcea\",\"animated\":false},{\"id\":\"reactflow__edge-bdbdad5d-40c3-4b5d-a268-367bebea132cresult-aab11907-275a-466c-a101-62f17f781af6sourcec\",\"source\":\"bdbdad5d-40c3-4b5d-a268-367bebea132c\",\"target\":\"aab11907-275a-466c-a101-62f17f781af6\",\"selected\":false,\"sourceHandle\":\"result\",\"targetHandle\":\"sourcec\",\"animated\":false},{\"id\":\"reactflow__edge-99f3a883-c62f-4258-bb35-236345f3fe4fresult-45eaec8e-83f6-4c42-b4f2-b53c675a6c60sourceb\",\"source\":\"99f3a883-c62f-4258-bb35-236345f3fe4f\",\"target\":\"45eaec8e-83f6-4c42-b4f2-b53c675a6c60\",\"selected\":false,\"sourceHandle\":\"result\",\"targetHandle\":\"sourceb\",\"animated\":false},{\"id\":\"reactflow__edge-45eaec8e-83f6-4c42-b4f2-b53c675a6c60result-88f3cf30-d968-4a19-8c11-b7f76256a4e1sourcea\",\"source\":\"45eaec8e-83f6-4c42-b4f2-b53c675a6c60\",\"target\":\"88f3cf30-d968-4a19-8c11-b7f76256a4e1\",\"selected\":false,\"sourceHandle\":\"result\",\"targetHandle\":\"sourcea\",\"animated\":false},{\"id\":\"reactflow__edge-88f3cf30-d968-4a19-8c11-b7f76256a4e1result-88f3cf30-d968-4a19-8c11-b7f76256a4e1-1726562748696sourcea\",\"source\":\"88f3cf30-d968-4a19-8c11-b7f76256a4e1\",\"target\":\"88f3cf30-d968-4a19-8c11-b7f76256a4e1-1726562748696\",\"selected\":false,\"sourceHandle\":\"result\",\"targetHandle\":\"sourcea\",\"animated\":false},{\"id\":\"reactflow__edge-88f3cf30-d968-4a19-8c11-b7f76256a4e1-1726562748696result-58771a3b-dcbe-4819-bd6d-d88b333121c5maintable\",\"source\":\"88f3cf30-d968-4a19-8c11-b7f76256a4e1-1726562748696\",\"target\":\"58771a3b-dcbe-4819-bd6d-d88b333121c5\",\"selected\":false,\"sourceHandle\":\"result\",\"targetHandle\":\"maintable\",\"animated\":false},{\"id\":\"58771a3b-dcbe-4819-bd6d-d88b333121c5result-1088be6d-95df-423e-9310-d3a4d50106b7source\",\"source\":\"58771a3b-dcbe-4819-bd6d-d88b333121c5\",\"target\":\"1088be6d-95df-423e-9310-d3a4d50106b7\",\"selected\":false,\"className\":\"\",\"sourceHandle\":\"result\",\"targetHandle\":\"source\",\"animated\":false},{\"id\":\"acb5859d-3ddb-4336-82eb-e7a0cd7a7eeeresult-0197a4ab-452a-4a13-86f9-73d70d178c38source\",\"source\":\"acb5859d-3ddb-4336-82eb-e7a0cd7a7eee\",\"target\":\"0197a4ab-452a-4a13-86f9-73d70d178c38\",\"selected\":false,\"className\":\"\",\"sourceHandle\":\"result\",\"targetHandle\":\"source\",\"animated\":false},{\"id\":\"0197a4ab-452a-4a13-86f9-73d70d178c38result-0e302f19-01d3-4b43-a003-0550b2f8ee78source\",\"source\":\"0197a4ab-452a-4a13-86f9-73d70d178c38\",\"target\":\"0e302f19-01d3-4b43-a003-0550b2f8ee78\",\"selected\":false,\"className\":\"\",\"sourceHandle\":\"result\",\"targetHandle\":\"source\",\"animated\":false},{\"id\":\"0e302f19-01d3-4b43-a003-0550b2f8ee78result-378b3189-8c1f-4190-91b5-3827596edeedsource\",\"source\":\"0e302f19-01d3-4b43-a003-0550b2f8ee78\",\"target\":\"378b3189-8c1f-4190-91b5-3827596edeed\",\"selected\":false,\"className\":\"\",\"sourceHandle\":\"result\",\"targetHandle\":\"source\",\"animated\":false},{\"id\":\"reactflow__edge-378b3189-8c1f-4190-91b5-3827596edeedresult-58771a3b-dcbe-4819-bd6d-d88b333121c5secondarytable\",\"source\":\"378b3189-8c1f-4190-91b5-3827596edeed\",\"target\":\"58771a3b-dcbe-4819-bd6d-d88b333121c5\",\"selected\":false,\"sourceHandle\":\"result\",\"targetHandle\":\"secondarytable\",\"animated\":false},{\"id\":\"1088be6d-95df-423e-9310-d3a4d50106b7result-9504b68e-364d-4c07-be20-4ac26b174f35source\",\"source\":\"1088be6d-95df-423e-9310-d3a4d50106b7\",\"target\":\"9504b68e-364d-4c07-be20-4ac26b174f35\",\"selected\":false,\"className\":\"\",\"sourceHandle\":\"result\",\"targetHandle\":\"source\",\"animated\":false},{\"id\":\"reactflow__edge-9504b68e-364d-4c07-be20-4ac26b174f35result-a6239dad-2039-4079-81f1-0ebc6a96248dsource\",\"source\":\"9504b68e-364d-4c07-be20-4ac26b174f35\",\"target\":\"a6239dad-2039-4079-81f1-0ebc6a96248d\",\"selected\":false,\"sourceHandle\":\"result\",\"targetHandle\":\"source\",\"animated\":false},{\"id\":\"8e2c0bf3-e0b2-465f-b865-5d1b78483f09\",\"type\":\"default\",\"source\":\"f63d9b1c-20c0-4215-bafa-4760f8ef1061\",\"target\":\"72e9de9d-fd56-4bff-af57-25be39504475\",\"sourceHandle\":\"out\",\"targetHandle\":\"table\",\"animated\":false},{\"id\":\"843b7c4f-089e-4dbd-8d43-bb3a7b90a584\",\"type\":\"default\",\"source\":\"f63d9b1c-20c0-4215-bafa-4760f8ef1061\",\"target\":\"aab11907-275a-466c-a101-62f17f781af6\",\"sourceHandle\":\"out\",\"targetHandle\":\"sourcea\",\"animated\":false},{\"id\":\"ecb94470-33e4-4b6c-b2ee-4fb39fb318cd\",\"type\":\"default\",\"source\":\"f63d9b1c-20c0-4215-bafa-4760f8ef1061\",\"target\":\"45eaec8e-83f6-4c42-b4f2-b53c675a6c60\",\"sourceHandle\":\"out\",\"targetHandle\":\"sourcea\",\"animated\":false}],\"variables\":null,\"procedure\":{},\"schedule\":{},\"viewport\":{\"x\":124.22924418761136,\"y\":109.89663911797106,\"zoom\":0.6326832259203773},\"schemaVersion\":\"1.0.0\",\"connectionProvider\":\"bigquery\",\"useCache\":false}"}
  */
  BEGIN
  CREATE TEMPORARY TABLE `WORKFLOW_5536591692e166fc_f9c4e14996fe97ed_result`
  AS
    SELECT 'US' AS region,
    DATE_TRUNC(primary_date, WEEK(MONDAY)) AS week,
    holiday_name
    FROM `bigquery-public-data.ml_datasets.holidays_and_events_for_forecasting`
    WHERE region = 'US';
  END;
  BEGIN
  CREATE TEMPORARY TABLE `WORKFLOW_5536591692e166fc_087b008a8f7b7831_result`
  AS
    SELECT h3, week
    FROM `cartobq.sdsc24_ny_workshops.CHI_boundary_enriched`;
  END;
  BEGIN
  CREATE TEMPORARY TABLE `WORKFLOW_5536591692e166fc_56b4c78bc0dc6ded_result`
  AS
    SELECT week,
      STRING_AGG(holiday_name) holiday_name_concat,
      ANY_VALUE(region) region_any
    FROM `WORKFLOW_5536591692e166fc_f9c4e14996fe97ed_result`
    GROUP BY week;
  END;
  BEGIN
  CREATE TEMPORARY TABLE `WORKFLOW_5536591692e166fc_3ca58319f7fe423c_result`
  AS
    WITH __h3_kring AS
      (
        SELECT
          CASE
            WHEN h3 IS NULL
            THEN
              [STRUCT(CAST(NULL AS STRING) as index, 0 as distance)]
            ELSE
              `carto-un.carto`.H3_KRING_DISTANCES(
                  h3,
                  2
              )
          END
          AS h3_kring,
          *
        FROM `WORKFLOW_5536591692e166fc_087b008a8f7b7831_result`
        WHERE h3 IS NOT NULL
      )
    SELECT
      kring.index AS kring_index,
      kring.distance AS kring_distance,
      allvalues.* except(h3_kring)
    FROM
      __h3_kring allvalues,
      unnest(allvalues.h3_kring) kring;
  END;
  BEGIN
  CREATE TEMPORARY TABLE `WORKFLOW_5536591692e166fc_b39811d6c8d388f8_result`
  AS
    SELECT b.*, a.counts, a.total_pop_sum
    FROM `cartobq.sdsc24_ny_workshops.CHI_boundary_enriched` a
    JOIN `WORKFLOW_5536591692e166fc_3ca58319f7fe423c_result` b
    ON a.h3 = b.kring_index AND a.week = b.week;
  END;
  BEGIN
  CREATE TEMPORARY TABLE `WORKFLOW_5536591692e166fc_89956b9346a8bed2_result`
  AS
    SELECT h3, week, 
    SUM(counts/total_pop_sum) * 1000 AS counts_ratio_kring2
    FROM `WORKFLOW_5536591692e166fc_b39811d6c8d388f8_result`
    WHERE total_pop_sum > 0
    GROUP BY week, h3;
  END;
  BEGIN
  CREATE TEMPORARY TABLE `WORKFLOW_5536591692e166fc_496d0dba0664e7d1_result`
  AS
    SELECT a.*,
    CASE WHEN a.total_pop_sum > 0 THEN a.counts/a.total_pop_sum * 1000 ELSE 0 END AS counts_ratio,
    b.counts_ratio_kring2
    FROM `cartobq.sdsc24_ny_workshops.CHI_boundary_enriched` a
    JOIN `WORKFLOW_5536591692e166fc_89956b9346a8bed2_result` b
    ON a.h3 = b.h3 AND a.week = b.week;
  END;
  BEGIN
  CREATE TEMPORARY TABLE `WORKFLOW_5536591692e166fc_9503015f5d6fc1d4_result`
  AS
    SELECT *,
    LAG(counts_ratio, 1) OVER (PARTITION BY h3 ORDER BY week) AS counts_ratio_lag_1,
    LAG(counts_ratio, 2) OVER (PARTITION BY h3 ORDER BY week) AS counts_ratio_lag_2,
    LAG(counts_ratio, 3) OVER (PARTITION BY h3 ORDER BY week) AS counts_ratio_lag_3
    FROM `WORKFLOW_5536591692e166fc_496d0dba0664e7d1_result`;
  END;
  BEGIN
  CREATE TEMPORARY TABLE `WORKFLOW_5536591692e166fc_4f0cd9ac750ecff8_result`
  AS
    SELECT *,
    SIN(2 * ACOS(-1) * MONTH / 12) AS seasonal_sin,
    COS(2 * ACOS(-1) * MONTH / 12) AS seasonal_cos
    FROM `WORKFLOW_5536591692e166fc_9503015f5d6fc1d4_result`;
  END;
  BEGIN
  CREATE TEMPORARY TABLE `WORKFLOW_5536591692e166fc_018fa5f09cf77676_result`
  AS
    SELECT * EXCEPT (region_any),
      region_any AS region
    FROM `WORKFLOW_5536591692e166fc_56b4c78bc0dc6ded_result`;
  END;
  BEGIN
  CREATE TEMPORARY TABLE `WORKFLOW_5536591692e166fc_0ace08b44a10ed04_result`
  AS
    SELECT * EXCEPT (holiday_name_concat),
      holiday_name_concat AS holiday_name
    FROM `WORKFLOW_5536591692e166fc_018fa5f09cf77676_result`;
  END;
  BEGIN
  DECLARE alias STRING;
  CREATE TABLE `cartodb-on-gcp-datascience.workflows_temp.table_23143416_ce47_459e_8f5e_b08ba832abaf` AS
  SELECT * FROM `WORKFLOW_5536591692e166fc_0ace08b44a10ed04_result`
  WHERE 1=0;
  EXECUTE IMMEDIATE
  '''
    with __alias AS(
      SELECT CONCAT(
        '_joined.', column_name, ' AS ', column_name, '_joined'
      ) col_alias
      FROM `cartodb-on-gcp-datascience.workflows_temp`.INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'table_23143416_ce47_459e_8f5e_b08ba832abaf'
    )
    SELECT STRING_AGG(col_alias, ', ')
    FROM __alias
  '''
  INTO alias;
  DROP TABLE `cartodb-on-gcp-datascience.workflows_temp.table_23143416_ce47_459e_8f5e_b08ba832abaf`;
  EXECUTE IMMEDIATE
  REPLACE(
    '''CREATE TEMPORARY TABLE `WORKFLOW_5536591692e166fc_3468df137895fc39_result`
    AS
      SELECT
        _main.*,
        %s
      FROM
        `WORKFLOW_5536591692e166fc_4f0cd9ac750ecff8_result` AS _main
      LEFT JOIN
        `WORKFLOW_5536591692e166fc_0ace08b44a10ed04_result` AS _joined
      ON
        _main.week = _joined.week''',
    '%s',
    alias
  );
  END;
  BEGIN
  CREATE TEMPORARY TABLE `WORKFLOW_5536591692e166fc_b13d16b012d93689_result`
  AS
    SELECT * EXCEPT (holiday_name_joined),
      holiday_name_joined AS holiday_name
    FROM `WORKFLOW_5536591692e166fc_3468df137895fc39_result`;
  END;
  BEGIN
  CREATE TEMPORARY TABLE `WORKFLOW_5536591692e166fc_ade4626a4207fd05_result`
  AS
    SELECT * EXCEPT (week_joined, region_joined)
    FROM `WORKFLOW_5536591692e166fc_b13d16b012d93689_result`;
  END;
  BEGIN
  DROP TABLE IF EXISTS `<my-project>.<my-dataset>.CHI_boundary_enriched_w_lags`;
  CREATE TABLE IF NOT EXISTS `<my-project>.<my-dataset>.CHI_boundary_enriched_w_lags`
  CLUSTER BY h3
  AS
    SELECT * FROM `WORKFLOW_5536591692e166fc_ade4626a4207fd05_result`;
  END;
END;