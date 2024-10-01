-- WARNING: This procedure requires the Analytics Toolbox and assumes it will be located
-- at the following path: carto-un.carto. If you want to deploy and
-- run it in a different location, you will need to update the code accordingly.
CREATE OR REPLACE PROCEDURE
  `cartodb-on-gcp-datascience.workflows_temp.wfproc_89ae1310054a4219`(
)
BEGIN
  /*
   {"versionId":"d5f0e4534abea82f","paramsId":"97d170e1550eee4a","isImmutable":true,"diagramJson":"{\"tags\":[],\"edges\":[{\"id\":\"reactflow__edge-81f414d5-3ff3-4a3b-a129-95231e964517out-64efc1c7-a26a-4fe2-a177-1d37a921c533source\",\"source\":\"81f414d5-3ff3-4a3b-a129-95231e964517\",\"target\":\"64efc1c7-a26a-4fe2-a177-1d37a921c533\",\"animated\":false,\"selected\":false,\"sourceHandle\":\"out\",\"targetHandle\":\"source\"},{\"id\":\"64efc1c7-a26a-4fe2-a177-1d37a921c533result-4a53a7c0-a9c8-4b2e-9b1c-dd0ad96b92fasource\",\"source\":\"64efc1c7-a26a-4fe2-a177-1d37a921c533\",\"target\":\"4a53a7c0-a9c8-4b2e-9b1c-dd0ad96b92fa\",\"animated\":false,\"selected\":false,\"className\":\"\",\"sourceHandle\":\"result\",\"targetHandle\":\"source\"},{\"id\":\"reactflow__edge-4a53a7c0-a9c8-4b2e-9b1c-dd0ad96b92faresult-f7156066-1569-4ff7-ae8b-3c201c81b9fbsource\",\"source\":\"4a53a7c0-a9c8-4b2e-9b1c-dd0ad96b92fa\",\"target\":\"f7156066-1569-4ff7-ae8b-3c201c81b9fb\",\"animated\":false,\"selected\":false,\"sourceHandle\":\"result\",\"targetHandle\":\"source\"},{\"id\":\"reactflow__edge-f7156066-1569-4ff7-ae8b-3c201c81b9fbresult-1cb15037-ae9e-4fc1-a60f-4dc87d23eb57source\",\"source\":\"f7156066-1569-4ff7-ae8b-3c201c81b9fb\",\"target\":\"1cb15037-ae9e-4fc1-a60f-4dc87d23eb57\",\"animated\":false,\"selected\":false,\"sourceHandle\":\"result\",\"targetHandle\":\"source\"},{\"id\":\"reactflow__edge-4a53a7c0-a9c8-4b2e-9b1c-dd0ad96b92faresult-1cb15037-ae9e-4fc1-a60f-4dc87d23eb57-1725958800186source\",\"source\":\"4a53a7c0-a9c8-4b2e-9b1c-dd0ad96b92fa\",\"target\":\"1cb15037-ae9e-4fc1-a60f-4dc87d23eb57-1725958800186\",\"animated\":false,\"selected\":false,\"sourceHandle\":\"result\",\"targetHandle\":\"source\"},{\"id\":\"reactflow__edge-f7156066-1569-4ff7-ae8b-3c201c81b9fbresult-6be8d300-3f93-4cfb-a461-9d9d8c78f284source\",\"source\":\"f7156066-1569-4ff7-ae8b-3c201c81b9fb\",\"target\":\"6be8d300-3f93-4cfb-a461-9d9d8c78f284\",\"animated\":false,\"selected\":false,\"sourceHandle\":\"result\",\"targetHandle\":\"source\"}],\"nodes\":[{\"id\":\"81f414d5-3ff3-4a3b-a129-95231e964517\",\"data\":{\"id\":\"cartobq.sdsc24_ny_workshops.CHI_boundary_enriched\",\"name\":\"ReadTable\",\"size\":7403165,\"type\":\"table\",\"label\":\"CHI_boundary_enriched\",\"nrows\":180565,\"inputs\":[{\"name\":\"source\",\"type\":\"String\",\"title\":\"Source table\",\"value\":\"cartobq.sdsc24_ny_workshops.CHI_boundary_enriched\",\"description\":\"Read Table\"}],\"schema\":[{\"name\":\"week\",\"type\":\"timestamp\"},{\"name\":\"h3\",\"type\":\"string\"},{\"name\":\"counts\",\"type\":\"number\"},{\"name\":\"month\",\"type\":\"number\"}],\"enriched\":true,\"provider\":\"bigquery\",\"geomField\":\"h3:h3\",\"tableRegion\":\"US\",\"lastModified\":1725460456273,\"optimization\":{\"actions\":[{\"type\":\"cluster\",\"enabled\":false}],\"actionAvailable\":{\"msg\":\"<b>This table isn't optimized.</b> Creating a cluster based on geospatial data may improve performance.\",\"type\":\"createTable\",\"query\":\"CREATE TABLE {newTableName} CLUSTER BY h3 AS SELECT * FROM `cartobq.sdsc24_ny_workshops.CHI_boundary_enriched`\"}},\"originalSchema\":[{\"name\":\"week\",\"type\":\"DATE\"},{\"name\":\"h3\",\"type\":\"STRING\"},{\"name\":\"counts\",\"type\":\"INTEGER\"},{\"name\":\"month\",\"type\":\"INTEGER\"}]},\"type\":\"source\",\"width\":192,\"height\":64,\"zIndex\":2,\"dragging\":false,\"position\":{\"x\":-176,\"y\":272},\"selected\":false,\"positionAbsolute\":{\"x\":-176,\"y\":272}},{\"id\":\"1cb15037-ae9e-4fc1-a60f-4dc87d23eb57\",\"data\":{\"name\":\"native.saveastable\",\"inputs\":[{\"name\":\"source\",\"type\":\"Table\",\"title\":\"Source table\",\"description\":\"Source table\"},{\"name\":\"destination\",\"type\":\"OutputTable\",\"title\":\"Table details\",\"placeholder\":\"Rename and select destination\",\"description\":\"Table details\",\"value\":\"cartobq.sdsc24_ny_workshops.CHI_boundary_enriched_TS_hotspots_classification\"},{\"name\":\"append\",\"type\":\"Boolean\",\"title\":\"Append to existing table\",\"default\":false,\"description\":\"Append to existing table\",\"value\":false},{\"name\":\"optimizationcol\",\"type\":\"Column\",\"title\":\"Cluster by\",\"parent\":\"source\",\"parentOutput\":\"result\",\"dataType\":[\"geography\",\"boolean\",\"number\",\"string\",\"date\",\"datetime\",\"time\",\"timestamp\"],\"providers\":[\"bigquery\"],\"optional\":true,\"advanced\":true,\"description\":\"Cluster by\",\"value\":\"h3\"}],\"version\":\"1\",\"label\":\"Save as Table\"},\"type\":\"generic\",\"width\":64,\"height\":64,\"zIndex\":2,\"dragging\":false,\"position\":{\"x\":1216,\"y\":256},\"selected\":false,\"positionAbsolute\":{\"x\":1216,\"y\":256}},{\"id\":\"64efc1c7-a26a-4fe2-a177-1d37a921c533\",\"data\":{\"name\":\"native.getisordspacetime\",\"inputs\":[{\"name\":\"source\",\"type\":\"Table\",\"title\":\"Source table\",\"description\":\"Source table\"},{\"name\":\"indexcol\",\"type\":\"Column\",\"title\":\"Index column\",\"parent\":\"source\",\"dataType\":[\"string\",\"number\"],\"description\":\"Index column\",\"value\":\"h3\",\"options\":[\"h3\",\"counts\",\"year\",\"month\",\"total_pop_sum\",\"median_age_avg\",\"median_rent_avg\",\"black_pop_sum\",\"hispanic_pop_sum\",\"owner_occupied_housing_units_median_value_sum\",\"vacant_housing_units_sum\",\"housing_units_sum\",\"families_with_young_children_sum\",\"urbanity_any\",\"urbanity_any_ordinal\",\"principal_component_1\",\"principal_component_2\"]},{\"name\":\"datecol\",\"type\":\"Column\",\"title\":\"Date column\",\"parent\":\"source\",\"dataType\":[\"datetime\",\"timestamp\",\"date\"],\"description\":\"Date column\",\"value\":\"week\",\"options\":[\"week\"]},{\"name\":\"valuecol\",\"type\":\"Column\",\"title\":\"Value column\",\"parent\":\"source\",\"dataType\":[\"number\"],\"description\":\"Value column\",\"value\":\"counts\",\"options\":[\"counts\",\"year\",\"month\",\"total_pop_sum\",\"median_age_avg\",\"median_rent_avg\",\"black_pop_sum\",\"hispanic_pop_sum\",\"owner_occupied_housing_units_median_value_sum\",\"vacant_housing_units_sum\",\"housing_units_sum\",\"families_with_young_children_sum\",\"urbanity_any_ordinal\",\"principal_component_1\",\"principal_component_2\"]},{\"name\":\"kernel\",\"type\":\"Selection\",\"title\":\"Kernel function for spatial weights\",\"options\":[\"uniform\",\"triangular\",\"quadratic\",\"quartic\",\"gaussian\"],\"description\":\"Kernel function for spatial weights\",\"value\":\"gaussian\"},{\"name\":\"kerneltime\",\"type\":\"Selection\",\"title\":\"Kernel function for temporal weights\",\"options\":[\"uniform\",\"triangular\",\"quadratic\",\"quartic\",\"gaussian\"],\"description\":\"Kernel function for temporal weights\",\"value\":\"uniform\"},{\"name\":\"size\",\"type\":\"Number\",\"title\":\"Size\",\"default\":3,\"min\":1,\"max\":10,\"description\":\"Size\",\"value\":2},{\"name\":\"bandwidth\",\"type\":\"Number\",\"title\":\"Temporal bandwidth\",\"default\":3,\"min\":1,\"max\":10,\"description\":\"Temporal bandwidth\",\"value\":3},{\"name\":\"timeinterval\",\"type\":\"Selection\",\"title\":\"Time interval\",\"options\":[\"year\",\"quarter\",\"month\",\"week\",\"day\",\"hour\",\"minute\",\"second\"],\"description\":\"Time interval\",\"value\":\"week\"},{\"name\":\"optimizationcol\",\"type\":\"Column\",\"title\":\"Cluster by\",\"parent\":\"source\",\"parentOutput\":\"result\",\"dataType\":[\"geography\",\"boolean\",\"number\",\"string\",\"date\",\"datetime\",\"time\",\"timestamp\"],\"providers\":[\"bigquery\"],\"optional\":true,\"advanced\":true,\"description\":\"Cluster by\",\"value\":\"index\",\"options\":[\"index\",\"date\",\"gi\",\"p_value\"]}],\"version\":\"1\",\"label\":\"Getis Ord Spacetime\"},\"type\":\"generic\",\"width\":64,\"height\":64,\"zIndex\":2,\"dragging\":false,\"position\":{\"x\":256,\"y\":384},\"selected\":false,\"positionAbsolute\":{\"x\":256,\"y\":384}},{\"id\":\"f7156066-1569-4ff7-ae8b-3c201c81b9fb\",\"data\":{\"name\":\"native.spacetimehotspotsclassification\",\"inputs\":[{\"name\":\"source\",\"type\":\"Table\",\"title\":\"Source table\",\"description\":\"Source table\"},{\"name\":\"indexcol\",\"type\":\"Column\",\"title\":\"Index column\",\"parent\":\"source\",\"dataType\":[\"string\",\"number\"],\"description\":\"Index column\",\"value\":\"h3\",\"options\":[\"gi\",\"p_value\",\"h3\"]},{\"name\":\"datecol\",\"type\":\"Column\",\"title\":\"Date column\",\"parent\":\"source\",\"dataType\":[\"datetime\",\"timestamp\",\"date\"],\"description\":\"Date column\",\"value\":\"date\",\"options\":[\"date\"]},{\"name\":\"valuecol\",\"type\":\"Column\",\"title\":\"Gi Value\",\"helper\":\"Select a column that contains a Gi value generated by a Getis Ord Spacetime component\",\"default\":\"gi\",\"parent\":\"source\",\"dataType\":[\"number\"],\"description\":\"Gi Value\",\"value\":\"gi\",\"options\":[\"gi\",\"p_value\"]},{\"name\":\"pvaluecol\",\"type\":\"Column\",\"title\":\"P Value\",\"helper\":\"Select a column  that contains a P value generated by a Getis Ord Spacetime component\",\"default\":\"p_value\",\"parent\":\"source\",\"dataType\":[\"number\"],\"description\":\"P Value\",\"value\":\"p_value\",\"options\":[\"gi\",\"p_value\"]},{\"name\":\"threshold\",\"type\":\"Selection\",\"title\":\"Threshold\",\"helper\":\"Select the threshold of the P value for a location to be considered as hotspot/coldspot\",\"default\":0.05,\"options\":[0.01,0.05,0.1,1],\"description\":\"Threshold\",\"value\":0.05},{\"name\":\"algorithm\",\"type\":\"Selection\",\"title\":\"Algorithm\",\"helper\":\"The algorithm to be used for the monotonic trend test\",\"default\":\"Mann-Kendall\",\"options\":[\"Mann-Kendall\",\"Modified Mann-Kendall\"],\"description\":\"Algorithm\",\"value\":\"Modified Mann-Kendall\"},{\"name\":\"optimizationcol\",\"type\":\"Column\",\"title\":\"Cluster by\",\"parent\":\"source\",\"parentOutput\":\"result\",\"dataType\":[\"geography\",\"boolean\",\"number\",\"string\",\"date\",\"datetime\",\"time\",\"timestamp\"],\"providers\":[\"bigquery\"],\"optional\":true,\"advanced\":true,\"description\":\"Cluster by\",\"options\":[\"h3\",\"classification\",\"tau\",\"tau_p\"]}],\"version\":\"1\",\"label\":\"Spacetime Hotspots Classification\"},\"type\":\"generic\",\"width\":64,\"height\":64,\"zIndex\":2,\"dragging\":false,\"position\":{\"x\":720,\"y\":384},\"selected\":false,\"positionAbsolute\":{\"x\":720,\"y\":384}},{\"id\":\"4a53a7c0-a9c8-4b2e-9b1c-dd0ad96b92fa\",\"data\":{\"name\":\"native.renamecolumn\",\"inputs\":[{\"name\":\"source\",\"type\":\"Table\",\"title\":\"Source table\",\"description\":\"Source table\"},{\"name\":\"column\",\"type\":\"Column\",\"title\":\"Column to rename\",\"parent\":\"source\",\"dataType\":[\"boolean\",\"geography\",\"number\",\"string\"],\"description\":\"Column to rename\",\"value\":\"index\",\"options\":[\"index\",\"gi\",\"p_value\"]},{\"name\":\"newname\",\"type\":\"String\",\"title\":\"New column name\",\"validation\":\"^[a-zA-Z_][a-zA-Z0-9_]*$\",\"allowExpressions\":false,\"description\":\"New column name\",\"value\":\"h3\"},{\"name\":\"optimizationcol\",\"type\":\"Column\",\"title\":\"Cluster by\",\"parent\":\"source\",\"parentOutput\":\"result\",\"dataType\":[\"geography\",\"boolean\",\"number\",\"string\",\"date\",\"datetime\",\"time\",\"timestamp\"],\"providers\":[\"bigquery\"],\"optional\":true,\"advanced\":true,\"description\":\"Cluster by\",\"value\":\"h3\",\"options\":[\"date\",\"gi\",\"p_value\",\"h3\"]}],\"version\":\"1\",\"label\":\"Rename Column\"},\"type\":\"generic\",\"width\":64,\"height\":64,\"zIndex\":2,\"dragging\":false,\"position\":{\"x\":416,\"y\":384},\"selected\":false,\"positionAbsolute\":{\"x\":416,\"y\":384}},{\"id\":\"1cb15037-ae9e-4fc1-a60f-4dc87d23eb57-1725958800186\",\"data\":{\"name\":\"native.saveastable\",\"inputs\":[{\"name\":\"source\",\"type\":\"Table\",\"title\":\"Source table\",\"description\":\"Source table\"},{\"name\":\"destination\",\"type\":\"OutputTable\",\"title\":\"Table details\",\"placeholder\":\"Rename and select destination\",\"description\":\"Table details\",\"value\":\"cartobq.sdsc24_ny_workshops.CHI_boundary_enriched_TS_getis_ord\"},{\"name\":\"append\",\"type\":\"Boolean\",\"title\":\"Append to existing table\",\"default\":false,\"description\":\"Append to existing table\",\"value\":false},{\"name\":\"optimizationcol\",\"type\":\"Column\",\"title\":\"Cluster by\",\"parent\":\"source\",\"parentOutput\":\"result\",\"dataType\":[\"geography\",\"boolean\",\"number\",\"string\",\"date\",\"datetime\",\"time\",\"timestamp\"],\"providers\":[\"bigquery\"],\"optional\":true,\"advanced\":true,\"description\":\"Cluster by\",\"value\":\"h3\",\"options\":[\"date\",\"gi\",\"p_value\",\"h3\"]}],\"version\":\"1\",\"label\":\"Save as Table\"},\"type\":\"generic\",\"width\":64,\"height\":64,\"zIndex\":2,\"dragging\":true,\"position\":{\"x\":1216,\"y\":384},\"selected\":true,\"positionAbsolute\":{\"x\":1216,\"y\":384}},{\"id\":\"6be8d300-3f93-4cfb-a461-9d9d8c78f284\",\"data\":{\"name\":\"native.distinct\",\"inputs\":[{\"name\":\"source\",\"type\":\"Table\",\"title\":\"Source table\",\"description\":\"Source table\"},{\"name\":\"column\",\"type\":\"Column\",\"title\":\"Column\",\"parent\":\"source\",\"description\":\"Column\",\"value\":\"classification\",\"options\":[\"h3\",\"classification\",\"tau\",\"tau_p\"]},{\"name\":\"optimizationcol\",\"type\":\"Column\",\"title\":\"Cluster by\",\"parent\":\"source\",\"parentOutput\":\"result\",\"dataType\":[\"geography\",\"boolean\",\"number\",\"string\",\"date\",\"datetime\",\"time\",\"timestamp\"],\"providers\":[\"bigquery\"],\"optional\":true,\"advanced\":true,\"description\":\"Cluster by\",\"options\":[\"classification\"]}],\"version\":\"1\",\"label\":\"Select Distinct\"},\"type\":\"generic\",\"width\":64,\"height\":64,\"zIndex\":2,\"dragging\":false,\"position\":{\"x\":928,\"y\":256},\"selected\":false,\"positionAbsolute\":{\"x\":928,\"y\":256}},{\"id\":\"19b97412-e1f8-4830-b744-662f2b3b1cb4\",\"data\":{\"name\":\"Note\",\"color\":\"#8BE0A4\",\"genAi\":false,\"label\":\"\",\"width\":480,\"height\":511.993,\"inputs\":[],\"markdown\":\"---\\nlabel:\\n---\\n## Input data\",\"position\":{\"x\":-304,\"y\":0}},\"type\":\"note\",\"width\":480,\"height\":512,\"zIndex\":-1,\"dragging\":false,\"position\":{\"x\":-352,\"y\":0},\"selected\":false,\"positionAbsolute\":{\"x\":-352,\"y\":0}},{\"id\":\"19b97412-e1f8-4830-b744-662f2b3b1cb4-1726840343473\",\"data\":{\"name\":\"Note\",\"color\":\"#F89C74\",\"genAi\":false,\"label\":\"\",\"width\":896,\"height\":511.993,\"inputs\":[],\"markdown\":\"---\\nlabel:\\n---\\n## Hotspots analysis\\n\\nHotspot analysis identifies and measures the strength of spatio-temporal patterns by taking the user-defined neighborhood for each feature in a spatial table and calculating whether the values within that neighborhood are significantly higher or lower than across the entire table. \",\"position\":{\"x\":192,\"y\":0}},\"type\":\"note\",\"width\":896,\"height\":512,\"zIndex\":-1,\"dragging\":false,\"position\":{\"x\":144,\"y\":0},\"selected\":false,\"positionAbsolute\":{\"x\":144,\"y\":0}},{\"id\":\"19b97412-e1f8-4830-b744-662f2b3b1cb4-1726840343473-1726840372883\",\"data\":{\"name\":\"Note\",\"color\":\"#FE88B1\",\"genAi\":false,\"label\":\"\",\"width\":352,\"height\":511.999,\"inputs\":[],\"markdown\":\"---\\nlabel:\\n---\\n## Save results to a table\",\"position\":{\"x\":1104,\"y\":0}},\"type\":\"note\",\"width\":352,\"height\":512,\"zIndex\":-1,\"dragging\":false,\"position\":{\"x\":1056,\"y\":0},\"selected\":false,\"positionAbsolute\":{\"x\":1056,\"y\":0}},{\"id\":\"19b97412-e1f8-4830-b744-662f2b3b1cb4-1726840343473-1726840398700\",\"data\":{\"name\":\"Note\",\"color\":\"#F89C74\",\"genAi\":false,\"label\":\"\",\"width\":368,\"height\":303.999,\"inputs\":[],\"markdown\":\"---\\nlabel: Find space-time hotspots\\n---\\nCalculate the spatio-temporal Getis-Ord Gi* (GI*) statistic. Positive GI* values indicate that the neighborhood values are significantly higher than across the entire table - i.e. it is a hotspot - and negative GI* values indicate the reverse. \",\"position\":{\"x\":208,\"y\":191.993}},\"type\":\"note\",\"width\":368,\"height\":304,\"zIndex\":-1,\"dragging\":false,\"position\":{\"x\":160,\"y\":192},\"selected\":false,\"positionAbsolute\":{\"x\":160,\"y\":192}},{\"id\":\"19b97412-e1f8-4830-b744-662f2b3b1cb4-1726840343473-1726840398700-1726840428070\",\"data\":{\"name\":\"Note\",\"color\":\"#F89C74\",\"genAi\":false,\"label\":\"\",\"width\":480,\"height\":303.999,\"inputs\":[],\"markdown\":\"---\\nlabel: Classify space-time hotspots\\n---\\nOnce we have identified hot and cold spots, we can classify them into a set of predefined categories so that the results are easier to digest. \",\"position\":{\"x\":592,\"y\":191.993}},\"type\":\"note\",\"width\":480,\"height\":304,\"zIndex\":-1,\"dragging\":false,\"position\":{\"x\":544,\"y\":192},\"selected\":false,\"positionAbsolute\":{\"x\":544,\"y\":192}},{\"id\":\"19b97412-e1f8-4830-b744-662f2b3b1cb4-1727093607335\",\"data\":{\"name\":\"Note\",\"color\":\"#8BE0A4\",\"genAi\":false,\"label\":\"\",\"width\":448,\"height\":255.993,\"inputs\":[],\"markdown\":\"---\\nlabel: Chicago boundary enriched and pre-processed (FAMD) data\\n---\\n\",\"position\":{\"x\":-288,\"y\":80}},\"type\":\"note\",\"width\":448,\"height\":256,\"zIndex\":-1,\"dragging\":false,\"position\":{\"x\":-336,\"y\":160},\"selected\":false,\"positionAbsolute\":{\"x\":-336,\"y\":160}}],\"title\":\"(4/) SDSC Unlocking Smarter Property Risk Assessments with Spatio-Temporal Crime Insights and CARTO\",\"useCache\":true,\"viewport\":{\"x\":189.16290442527645,\"y\":-52.04703026402581,\"zoom\":0.4856537477708209},\"description\":\"\",\"thumbnailUrl\":\"\",\"schemaVersion\":\"1.0.0\",\"connectionProvider\":\"bigquery\"}"}
  */
  DECLARE __outputtable STRING;
  DECLARE __outputtablefqn STRING;
  SET __outputtable = 'wfproc_89ae1310054a4219_out_' || SUBSTRING(TO_HEX(MD5('')), 1, 16);
  SET __outputtablefqn = 'cartodb-on-gcp-datascience.workflows_temp.wfproc_89ae1310054a4219_out_' || SUBSTRING(TO_HEX(MD5('')), 1, 16);
  BEGIN
    BEGIN
    DECLARE grid_type STRING;
    DECLARE grid_resolution INT64;
    CALL `carto-un.carto`.__CHECK_GRID_INDEX_COLUMN(
        'SELECT * FROM `cartobq.sdsc24_ny_workshops.CHI_boundary_enriched`',
        'h3',
        grid_type,
        grid_resolution
    );
    IF grid_type = 'quadbin' THEN
        CALL `carto-un.carto`.GETIS_ORD_SPACETIME_QUADBIN_TABLE(
            'SELECT * EXCEPT (week), CAST(week AS DATETIME) AS week FROM `cartobq.sdsc24_ny_workshops.CHI_boundary_enriched`',
            'cartodb-on-gcp-datascience.workflows_temp.__temp_bf892a8b_4166_4044_9ab0_c02d91d977d5',
            'h3',
            'week',
            'counts',
            2,
            'week',
            3,
            'gaussian',
            'uniform'
        );
    ELSEIF grid_type = 'h3' THEN
        CALL `carto-un.carto`.GETIS_ORD_SPACETIME_H3_TABLE(
          'SELECT * EXCEPT (week), CAST(week AS DATETIME) AS week FROM `cartobq.sdsc24_ny_workshops.CHI_boundary_enriched`',
          'cartodb-on-gcp-datascience.workflows_temp.__temp_bf892a8b_4166_4044_9ab0_c02d91d977d5',
          'h3',
          'week',
          'counts',
          2,
          'week',
          3,
          'gaussian',
          'uniform'
        );
    ELSE
        RAISE USING MESSAGE = 'Invalid spatial index column, please select a column that contains h3 or quadbin indexes.';
    END IF;
    CREATE TEMPORARY TABLE `WORKFLOW_89ae1310054a4219_a4c2b4d1823c1cea_result`
    AS
      SELECT * FROM `cartodb-on-gcp-datascience.workflows_temp.__temp_bf892a8b_4166_4044_9ab0_c02d91d977d5`;
    END;
    BEGIN
    CREATE TEMPORARY TABLE `WORKFLOW_89ae1310054a4219_1c9ed88818c26f2c_result`
    CLUSTER BY h3
    AS
      SELECT * EXCEPT (index),
        index AS h3
      FROM `WORKFLOW_89ae1310054a4219_a4c2b4d1823c1cea_result`;
    END;
    BEGIN
    CALL `carto-un.carto`.SPACETIME_HOTSPOTS_CLASSIFICATION(
        'SELECT * EXCEPT (date), CAST(date AS DATETIME) AS date FROM `WORKFLOW_89ae1310054a4219_1c9ed88818c26f2c_result`',
        'cartodb-on-gcp-datascience.workflows_temp.__temp_6de9dd61_b6a7_4d4c_9eff_fec98f0b9368',
        'h3',
        'date',
        'gi',
        'p_value',
        '''
        {
          "threshold": 0.05,
          "algorithm": "mmk"
        }
        '''
      );
    CREATE TEMPORARY TABLE `WORKFLOW_89ae1310054a4219_d882ed1eff7b6ec5_result`
    AS
      SELECT * FROM `cartodb-on-gcp-datascience.workflows_temp.__temp_6de9dd61_b6a7_4d4c_9eff_fec98f0b9368`;
    END;
    BEGIN
    DROP TABLE IF EXISTS `cartobq.sdsc24_ny_workshops.CHI_boundary_enriched_TS_hotspots_classification`;
    CREATE TABLE IF NOT EXISTS `cartobq.sdsc24_ny_workshops.CHI_boundary_enriched_TS_hotspots_classification`
    AS
      SELECT * FROM `WORKFLOW_89ae1310054a4219_d882ed1eff7b6ec5_result`;
    END;
    BEGIN
    CREATE TEMPORARY TABLE `WORKFLOW_89ae1310054a4219_b3bb85d2536709b5_result`
    AS
      SELECT DISTINCT classification
      FROM `WORKFLOW_89ae1310054a4219_d882ed1eff7b6ec5_result`;
    END;
    BEGIN
    DROP TABLE IF EXISTS `cartobq.sdsc24_ny_workshops.CHI_boundary_enriched_TS_getis_ord`;
    CREATE TABLE IF NOT EXISTS `cartobq.sdsc24_ny_workshops.CHI_boundary_enriched_TS_getis_ord`
    CLUSTER BY h3
    AS
      SELECT * FROM `WORKFLOW_89ae1310054a4219_1c9ed88818c26f2c_result`;
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