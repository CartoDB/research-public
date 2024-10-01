-- WARNING: This procedure requires the Analytics Toolbox and assumes it will be located
-- at the following path: carto-un.carto. If you want to deploy and
-- run it in a different location, you will need to update the code accordingly.
CREATE OR REPLACE PROCEDURE
  `cartodb-on-gcp-datascience.workflows_temp.wfproc_54fd994649546936`(
)
BEGIN
  /*
   {"versionId":"0d4a27bb69dfbe94","paramsId":"97d170e1550eee4a","isImmutable":false,"diagramJson":"{\"tags\":[],\"edges\":[{\"id\":\"reactflow__edge-1ba5fd36-d0b7-4758-be22-e83a6f9c9819result-2a5325cf-4a72-4e30-b6f2-f3d1cd13cb97source\",\"source\":\"1ba5fd36-d0b7-4758-be22-e83a6f9c9819\",\"target\":\"2a5325cf-4a72-4e30-b6f2-f3d1cd13cb97\",\"animated\":false,\"sourceHandle\":\"result\",\"targetHandle\":\"source\"},{\"id\":\"2a5325cf-4a72-4e30-b6f2-f3d1cd13cb97match-edfbc23e-13d7-40ff-b853-091ef9725885table\",\"source\":\"2a5325cf-4a72-4e30-b6f2-f3d1cd13cb97\",\"target\":\"edfbc23e-13d7-40ff-b853-091ef9725885\",\"animated\":false,\"className\":\"\",\"sourceHandle\":\"match\",\"targetHandle\":\"table\"},{\"id\":\"edfbc23e-13d7-40ff-b853-091ef9725885result-5253a780-3c64-408a-b71a-551560630f7bsource\",\"source\":\"edfbc23e-13d7-40ff-b853-091ef9725885\",\"target\":\"5253a780-3c64-408a-b71a-551560630f7b\",\"animated\":false,\"className\":\"\",\"sourceHandle\":\"result\",\"targetHandle\":\"source\"},{\"id\":\"reactflow__edge-5253a780-3c64-408a-b71a-551560630f7bmatch-48cd39d6-9e51-463e-943d-e3e38e595c76secondarytable\",\"source\":\"5253a780-3c64-408a-b71a-551560630f7b\",\"target\":\"48cd39d6-9e51-463e-943d-e3e38e595c76\",\"animated\":false,\"sourceHandle\":\"match\",\"targetHandle\":\"secondarytable\"},{\"id\":\"reactflow__edge-1ba5fd36-d0b7-4758-be22-e83a6f9c9819result-48cd39d6-9e51-463e-943d-e3e38e595c76maintable\",\"source\":\"1ba5fd36-d0b7-4758-be22-e83a6f9c9819\",\"target\":\"48cd39d6-9e51-463e-943d-e3e38e595c76\",\"animated\":false,\"sourceHandle\":\"result\",\"targetHandle\":\"maintable\"},{\"id\":\"48cd39d6-9e51-463e-943d-e3e38e595c76result-bbeecc5a-353a-4840-9481-ed610395413bsourcea\",\"source\":\"48cd39d6-9e51-463e-943d-e3e38e595c76\",\"target\":\"bbeecc5a-353a-4840-9481-ed610395413b\",\"animated\":false,\"className\":\"\",\"sourceHandle\":\"result\",\"targetHandle\":\"sourcea\"},{\"id\":\"reactflow__edge-7cd1a42b-e688-4419-b70f-c273e9c43a9bresult-fc562c36-2bf2-45ab-91d3-296fbf4dbe26sourceb\",\"source\":\"7cd1a42b-e688-4419-b70f-c273e9c43a9b\",\"target\":\"fc562c36-2bf2-45ab-91d3-296fbf4dbe26\",\"animated\":false,\"sourceHandle\":\"result\",\"targetHandle\":\"sourceb\"},{\"id\":\"reactflow__edge-b40971a4-d394-411f-bc2c-6786f85dc072result-fc562c36-2bf2-45ab-91d3-296fbf4dbe26sourcea\",\"source\":\"b40971a4-d394-411f-bc2c-6786f85dc072\",\"target\":\"fc562c36-2bf2-45ab-91d3-296fbf4dbe26\",\"animated\":false,\"sourceHandle\":\"result\",\"targetHandle\":\"sourcea\"},{\"id\":\"reactflow__edge-fc562c36-2bf2-45ab-91d3-296fbf4dbe26result-fd1e0d19-8622-4c70-95fd-99e0e2969faesecondarytable\",\"source\":\"fc562c36-2bf2-45ab-91d3-296fbf4dbe26\",\"target\":\"fd1e0d19-8622-4c70-95fd-99e0e2969fae\",\"animated\":false,\"selected\":false,\"sourceHandle\":\"result\",\"targetHandle\":\"secondarytable\"},{\"id\":\"reactflow__edge-bbeecc5a-353a-4840-9481-ed610395413bresult-50941775-9361-4c59-a7c1-f2fcd982607esource\",\"source\":\"bbeecc5a-353a-4840-9481-ed610395413b\",\"target\":\"50941775-9361-4c59-a7c1-f2fcd982607e\",\"animated\":false,\"sourceHandle\":\"result\",\"targetHandle\":\"source\"},{\"id\":\"50941775-9361-4c59-a7c1-f2fcd982607ematch-b9a8d3b2-6fcc-43b6-84f6-734e1c931820source\",\"source\":\"50941775-9361-4c59-a7c1-f2fcd982607e\",\"target\":\"b9a8d3b2-6fcc-43b6-84f6-734e1c931820\",\"animated\":false,\"className\":\"\",\"sourceHandle\":\"match\",\"targetHandle\":\"source\"},{\"id\":\"b9a8d3b2-6fcc-43b6-84f6-734e1c931820result-8d6ad481-2189-47f7-a0a8-aeec055d8d5csource\",\"source\":\"b9a8d3b2-6fcc-43b6-84f6-734e1c931820\",\"target\":\"8d6ad481-2189-47f7-a0a8-aeec055d8d5c\",\"animated\":false,\"className\":\"\",\"sourceHandle\":\"result\",\"targetHandle\":\"source\"},{\"id\":\"8d6ad481-2189-47f7-a0a8-aeec055d8d5cresult-127af41c-14b7-465a-86f1-26e288ae2ee2source\",\"source\":\"8d6ad481-2189-47f7-a0a8-aeec055d8d5c\",\"target\":\"127af41c-14b7-465a-86f1-26e288ae2ee2\",\"animated\":false,\"className\":\"\",\"sourceHandle\":\"result\",\"targetHandle\":\"source\"},{\"id\":\"reactflow__edge-e3f82db5-3dcc-4daa-b58a-15fa56da0d98result-6f082e9d-0e8e-4c93-938f-5a4267bfa4f0sourcec\",\"source\":\"e3f82db5-3dcc-4daa-b58a-15fa56da0d98\",\"target\":\"6f082e9d-0e8e-4c93-938f-5a4267bfa4f0\",\"animated\":false,\"sourceHandle\":\"result\",\"targetHandle\":\"sourcec\"},{\"id\":\"reactflow__edge-6f082e9d-0e8e-4c93-938f-5a4267bfa4f0result-b40971a4-d394-411f-bc2c-6786f85dc072source\",\"source\":\"6f082e9d-0e8e-4c93-938f-5a4267bfa4f0\",\"target\":\"b40971a4-d394-411f-bc2c-6786f85dc072\",\"animated\":false,\"sourceHandle\":\"result\",\"targetHandle\":\"source\"},{\"id\":\"reactflow__edge-b40971a4-d394-411f-bc2c-6786f85dc072result-fd1e0d19-8622-4c70-95fd-99e0e2969faemaintable\",\"source\":\"b40971a4-d394-411f-bc2c-6786f85dc072\",\"target\":\"fd1e0d19-8622-4c70-95fd-99e0e2969fae\",\"animated\":false,\"sourceHandle\":\"result\",\"targetHandle\":\"maintable\"},{\"id\":\"fd1e0d19-8622-4c70-95fd-99e0e2969faeresult-7ae102bf-068b-4700-aca2-4a9dcb67aa2fsource\",\"source\":\"fd1e0d19-8622-4c70-95fd-99e0e2969fae\",\"target\":\"7ae102bf-068b-4700-aca2-4a9dcb67aa2f\",\"animated\":false,\"className\":\"\",\"sourceHandle\":\"result\",\"targetHandle\":\"source\"},{\"id\":\"7ae102bf-068b-4700-aca2-4a9dcb67aa2fresult-01a665bd-7166-403e-89c5-776014f70ed0source\",\"source\":\"7ae102bf-068b-4700-aca2-4a9dcb67aa2f\",\"target\":\"01a665bd-7166-403e-89c5-776014f70ed0\",\"animated\":false,\"selected\":false,\"className\":\"\",\"sourceHandle\":\"result\",\"targetHandle\":\"source\"},{\"id\":\"reactflow__edge-127af41c-14b7-465a-86f1-26e288ae2ee2result-088f73e9-307a-44c6-a66f-d1da05ebf53esourcea\",\"source\":\"127af41c-14b7-465a-86f1-26e288ae2ee2\",\"target\":\"088f73e9-307a-44c6-a66f-d1da05ebf53e\",\"animated\":false,\"sourceHandle\":\"result\",\"targetHandle\":\"sourcea\"},{\"id\":\"reactflow__edge-088f73e9-307a-44c6-a66f-d1da05ebf53eresult-6f082e9d-0e8e-4c93-938f-5a4267bfa4f0sourcea\",\"source\":\"088f73e9-307a-44c6-a66f-d1da05ebf53e\",\"target\":\"6f082e9d-0e8e-4c93-938f-5a4267bfa4f0\",\"animated\":false,\"sourceHandle\":\"result\",\"targetHandle\":\"sourcea\"},{\"id\":\"reactflow__edge-01a665bd-7166-403e-89c5-776014f70ed0result-be8e5b12-ec46-4b17-81b0-e341acdb13f6sourcea\",\"source\":\"01a665bd-7166-403e-89c5-776014f70ed0\",\"target\":\"be8e5b12-ec46-4b17-81b0-e341acdb13f6\",\"animated\":false,\"sourceHandle\":\"result\",\"targetHandle\":\"sourcea\"},{\"id\":\"reactflow__edge-be8e5b12-ec46-4b17-81b0-e341acdb13f6result-6071942b-e04d-4e45-9952-c90ce75f843bsource\",\"source\":\"be8e5b12-ec46-4b17-81b0-e341acdb13f6\",\"target\":\"6071942b-e04d-4e45-9952-c90ce75f843b\",\"animated\":false,\"sourceHandle\":\"result\",\"targetHandle\":\"source\"},{\"id\":\"6ea8981c-57a6-4ca9-9740-153121408a60out-7cd1a42b-e688-4419-b70f-c273e9c43a9bsource\",\"source\":\"6ea8981c-57a6-4ca9-9740-153121408a60\",\"target\":\"7cd1a42b-e688-4419-b70f-c273e9c43a9b\",\"animated\":false,\"selected\":false,\"className\":\"\",\"sourceHandle\":\"out\",\"targetHandle\":\"source\"},{\"id\":\"reactflow__edge-6ea8981c-57a6-4ca9-9740-153121408a60out-be8e5b12-ec46-4b17-81b0-e341acdb13f6sourceb\",\"source\":\"6ea8981c-57a6-4ca9-9740-153121408a60\",\"target\":\"be8e5b12-ec46-4b17-81b0-e341acdb13f6\",\"animated\":false,\"selected\":false,\"sourceHandle\":\"out\",\"targetHandle\":\"sourceb\"}],\"nodes\":[{\"id\":\"1ba5fd36-d0b7-4758-be22-e83a6f9c9819\",\"data\":{\"name\":\"native.customsql\",\"inputs\":[{\"name\":\"sourcea\",\"type\":\"Table\",\"title\":\"Source table a\",\"optional\":true,\"description\":\"Source table a\"},{\"name\":\"sourceb\",\"type\":\"Table\",\"title\":\"Source table b\",\"optional\":true,\"description\":\"Source table b\"},{\"name\":\"sourcec\",\"type\":\"Table\",\"title\":\"Source table c\",\"optional\":true,\"description\":\"Source table c\"},{\"name\":\"sql\",\"type\":\"StringSql\",\"title\":\"SQL SELECT statement\",\"mode\":\"multiline\",\"placeholder\":\"SELECT ST_Centroid(geom) AS geom,\\n  AVG(value) AS average_value,\\n  category\\nFROM $a\\nGROUP BY category\",\"allowExpressions\":false,\"description\":\"SQL SELECT statement\",\"value\":\"SELECT \\n    unique_key,\\n    date,\\n    block,\\n    longitude,\\n    latitude,\\n    primary_type,\\nFROM `bigquery-public-data.chicago_crime.crime`\\nWHERE (LOWER(description) LIKE '%aggravated%' OR LOWER(description) LIKE '%murder%' ) AND LOWER(description) NOT LIKE '%non-aggravated%'\"},{\"name\":\"optimizationcol\",\"type\":\"Column\",\"title\":\"Cluster by\",\"parent\":\"source\",\"parentOutput\":\"result\",\"dataType\":[\"geography\",\"boolean\",\"number\",\"string\",\"date\",\"datetime\",\"time\",\"timestamp\"],\"providers\":[\"bigquery\"],\"optional\":true,\"advanced\":true,\"description\":\"Cluster by\"}],\"version\":\"2.0.0\",\"label\":\"Custom SQL Select\"},\"type\":\"generic\",\"width\":64,\"height\":64,\"zIndex\":2,\"dragging\":false,\"position\":{\"x\":-624,\"y\":256},\"selected\":false,\"positionAbsolute\":{\"x\":-624,\"y\":256}},{\"id\":\"5253a780-3c64-408a-b71a-551560630f7b\",\"data\":{\"name\":\"native.geocode\",\"inputs\":[{\"name\":\"source\",\"type\":\"Table\",\"title\":\"Source table\",\"description\":\"Source table\"},{\"name\":\"address\",\"type\":\"Column\",\"title\":\"Column with addresses\",\"parent\":\"source\",\"placeholder\":\"address\",\"dataType\":[\"string\"],\"description\":\"Column with addresses\",\"value\":\"block\",\"options\":[\"block\"]},{\"name\":\"country\",\"type\":\"Selection\",\"title\":\"Country\",\"optional\":true,\"default\":null,\"options\":[\"Afghanistan\",\"land Islands\",\"Albania\",\"Algeria\",\"American Samoa\",\"Andorra\",\"Angola\",\"Anguilla\",\"Antarctica\",\"Antigua and Barbuda\",\"Argentina\",\"Armenia\",\"Aruba\",\"Australia\",\"Austria\",\"Azerbaijan\",\"Bahamas\",\"Bahrain\",\"Bangladesh\",\"Barbados\",\"Belarus\",\"Belgium\",\"Belize\",\"Benin\",\"Bermuda\",\"Bhutan\",\"Bolivia\",\"Bosnia and Herzegovina\",\"Botswana\",\"Bouvet Island\",\"Brazil\",\"British Indian Ocean Territory\",\"Brunei Darussalam\",\"Bulgaria\",\"Burkina Faso\",\"Burundi\",\"Cambodia\",\"Cameroon\",\"Canada\",\"Cape Verde\",\"Cayman Islands\",\"Central African Republic\",\"Chad\",\"Chile\",\"China\",\"Christmas Island\",\"Cocos (Keeling) Islands\",\"Colombia\",\"Comoros\",\"Congo\",\"Congo, The Democratic Republic of the\",\"Cook Islands\",\"Costa Rica\",\"Cote D\\\"Ivoire\",\"Croatia\",\"Cuba\",\"Cyprus\",\"Czech Republic\",\"Denmark\",\"Djibouti\",\"Dominica\",\"Dominican Republic\",\"Ecuador\",\"Egypt\",\"El Salvador\",\"Equatorial Guinea\",\"Eritrea\",\"Estonia\",\"Ethiopia\",\"Falkland Islands (Malvinas)\",\"Faroe Islands\",\"Fiji\",\"Finland\",\"France\",\"French Guiana\",\"French Polynesia\",\"French Southern Territories\",\"Gabon\",\"Gambia\",\"Georgia\",\"Germany\",\"Ghana\",\"Gibraltar\",\"Greece\",\"Greenland\",\"Grenada\",\"Guadeloupe\",\"Guam\",\"Guatemala\",\"Guernsey\",\"Guinea\",\"Guinea-Bissau\",\"Guyana\",\"Haiti\",\"Heard Island and Mcdonald Islands\",\"Holy See (Vatican City State)\",\"Honduras\",\"Hong Kong\",\"Hungary\",\"Iceland\",\"India\",\"Indonesia\",\"Iran, Islamic Republic Of\",\"Iraq\",\"Ireland\",\"Isle of Man\",\"Israel\",\"Italy\",\"Jamaica\",\"Japan\",\"Jersey\",\"Jordan\",\"Kazakhstan\",\"Kenya\",\"Kiribati\",\"Korea, Democratic People\\\"S Republic of\",\"Korea, Republic of\",\"Kuwait\",\"Kyrgyzstan\",\"Lao People\\\"S Democratic Republic\",\"Latvia\",\"Lebanon\",\"Lesotho\",\"Liberia\",\"Libyan Arab Jamahiriya\",\"Liechtenstein\",\"Lithuania\",\"Luxembourg\",\"Macao\",\"Macedonia, The Former Yugoslav Republic of\",\"Madagascar\",\"Malawi\",\"Malaysia\",\"Maldives\",\"Mali\",\"Malta\",\"Marshall Islands\",\"Martinique\",\"Mauritania\",\"Mauritius\",\"Mayotte\",\"Mexico\",\"Micronesia, Federated States of\",\"Moldova, Republic of\",\"Monaco\",\"Mongolia\",\"Montenegro\",\"Montserrat\",\"Morocco\",\"Mozambique\",\"Myanmar\",\"Namibia\",\"Nauru\",\"Nepal\",\"Netherlands\",\"Netherlands Antilles\",\"New Caledonia\",\"New Zealand\",\"Nicaragua\",\"Niger\",\"Nigeria\",\"Niue\",\"Norfolk Island\",\"Northern Mariana Islands\",\"Norway\",\"Oman\",\"Pakistan\",\"Palau\",\"Palestinian Territory, Occupied\",\"Panama\",\"Papua New Guinea\",\"Paraguay\",\"Peru\",\"Philippines\",\"Pitcairn\",\"Poland\",\"Portugal\",\"Puerto Rico\",\"Qatar\",\"Reunion\",\"Romania\",\"Russian Federation\",\"RWANDA\",\"Saint Helena\",\"Saint Kitts and Nevis\",\"Saint Lucia\",\"Saint Pierre and Miquelon\",\"Saint Vincent and the Grenadines\",\"Samoa\",\"San Marino\",\"Sao Tome and Principe\",\"Saudi Arabia\",\"Senegal\",\"Serbia\",\"Seychelles\",\"Sierra Leone\",\"Singapore\",\"Slovakia\",\"Slovenia\",\"Solomon Islands\",\"Somalia\",\"South Africa\",\"South Georgia and the South Sandwich Islands\",\"Spain\",\"Sri Lanka\",\"Sudan\",\"Suriname\",\"Svalbard and Jan Mayen\",\"Swaziland\",\"Sweden\",\"Switzerland\",\"Syrian Arab Republic\",\"Taiwan, Province of China\",\"Tajikistan\",\"Tanzania, United Republic of\",\"Thailand\",\"Timor-Leste\",\"Togo\",\"Tokelau\",\"Tonga\",\"Trinidad and Tobago\",\"Tunisia\",\"Turkey\",\"Turkmenistan\",\"Turks and Caicos Islands\",\"Tuvalu\",\"Uganda\",\"Ukraine\",\"United Arab Emirates\",\"United Kingdom\",\"United States\",\"United States Minor Outlying Islands\",\"Uruguay\",\"Uzbekistan\",\"Vanuatu\",\"Venezuela\",\"Viet Nam\",\"Virgin Islands, British\",\"Virgin Islands, U.S.\",\"Wallis and Futuna\",\"Western Sahara\",\"Yemen\",\"Zambia\",\"Zimbabwe\"],\"description\":\"Country\",\"value\":\"United States\"},{\"name\":\"customoptions\",\"type\":\"String\",\"title\":\"Geocoding options\",\"default\":\"\",\"optional\":true,\"mode\":\"multiline\",\"allowExpressions\":false,\"description\":\"Geocoding options\",\"value\":\"\"}],\"version\":\"1\",\"label\":\"ST Geocode\"},\"type\":\"generic\",\"width\":64,\"height\":64,\"zIndex\":2,\"dragging\":false,\"position\":{\"x\":144,\"y\":144},\"selected\":true,\"positionAbsolute\":{\"x\":144,\"y\":144}},{\"id\":\"2a5325cf-4a72-4e30-b6f2-f3d1cd13cb97\",\"data\":{\"name\":\"native.where\",\"inputs\":[{\"name\":\"source\",\"type\":\"Table\",\"title\":\"Source table\",\"description\":\"Source table\"},{\"name\":\"expression\",\"type\":\"StringSql\",\"title\":\"Filter expression\",\"placeholder\":\"E.g.: area > 1000 AND area < 3000\",\"description\":\"Filter expression\",\"value\":\"longitude IS NULL OR latitude IS NULL\"},{\"name\":\"optimizationcol\",\"type\":\"Column\",\"title\":\"Cluster by\",\"parent\":\"source\",\"parentOutput\":\"match\",\"dataType\":[\"geography\",\"boolean\",\"number\",\"string\",\"date\",\"datetime\",\"time\",\"timestamp\"],\"providers\":[\"bigquery\"],\"optional\":true,\"advanced\":true,\"description\":\"Cluster by\",\"options\":[\"unique_key\",\"date\",\"block\",\"longitude\",\"latitude\",\"primary_type\"]}],\"version\":\"1\",\"label\":\"Where\"},\"type\":\"generic\",\"width\":64,\"height\":64,\"zIndex\":2,\"dragging\":false,\"position\":{\"x\":-208,\"y\":256},\"selected\":false,\"positionAbsolute\":{\"x\":-208,\"y\":256}},{\"id\":\"edfbc23e-13d7-40ff-b853-091ef9725885\",\"data\":{\"name\":\"native.select\",\"inputs\":[{\"name\":\"table\",\"type\":\"Table\",\"title\":\"Source table\",\"optional\":true,\"description\":\"Source table\"},{\"name\":\"select\",\"type\":\"StringSql\",\"title\":\"SELECT statement\",\"placeholder\":\"E.g.: *, distance_in_km * 1000 AS distance_in_meters\",\"allowExpressions\":false,\"description\":\"SELECT statement\",\"value\":\"DISTINCT(CONCAT(block, ', Chicago, IL')) AS block\"},{\"name\":\"optimizationcol\",\"type\":\"Column\",\"title\":\"Cluster by\",\"parent\":\"source\",\"parentOutput\":\"result\",\"dataType\":[\"geography\",\"boolean\",\"number\",\"string\",\"date\",\"datetime\",\"time\",\"timestamp\"],\"providers\":[\"bigquery\"],\"optional\":true,\"advanced\":true,\"description\":\"Cluster by\"}],\"version\":\"1\",\"label\":\"Select\"},\"type\":\"generic\",\"width\":64,\"height\":64,\"zIndex\":2,\"dragging\":false,\"position\":{\"x\":-32,\"y\":192},\"selected\":false,\"positionAbsolute\":{\"x\":-32,\"y\":192}},{\"id\":\"48cd39d6-9e51-463e-943d-e3e38e595c76\",\"data\":{\"name\":\"native.join\",\"inputs\":[{\"name\":\"maintable\",\"type\":\"Table\",\"title\":\"Main table\",\"description\":\"Main table\"},{\"name\":\"secondarytable\",\"type\":\"Table\",\"title\":\"Secondary table\",\"description\":\"Secondary table\"},{\"name\":\"maincolumn\",\"type\":\"Column\",\"title\":\"Column in main table\",\"parent\":\"maintable\",\"dataType\":[\"boolean\",\"date\",\"datetime\",\"time\",\"timestamp\",\"number\",\"string\"],\"description\":\"Column in main table\",\"value\":\"block\",\"options\":[\"unique_key\",\"date\",\"block\",\"longitude\",\"latitude\",\"primary_type\"]},{\"name\":\"secondarycolumn\",\"type\":\"Column\",\"title\":\"Column in secondary table\",\"parent\":\"secondarytable\",\"dataType\":[\"boolean\",\"date\",\"datetime\",\"time\",\"timestamp\",\"number\",\"string\"],\"description\":\"Column in secondary table\",\"value\":\"block\",\"options\":[\"block\",\"carto_geocode_metadata\"]},{\"name\":\"jointype\",\"type\":\"Selection\",\"title\":\"Join type\",\"options\":[\"Inner\",\"Left\",\"Right\",\"Full outer\"],\"default\":\"Inner\",\"description\":\"Join type\",\"value\":\"Left\"},{\"name\":\"optimizationcol\",\"type\":\"Column\",\"title\":\"Cluster by\",\"parent\":\"source\",\"parentOutput\":\"result\",\"dataType\":[\"geography\",\"boolean\",\"number\",\"string\",\"date\",\"datetime\",\"time\",\"timestamp\"],\"providers\":[\"bigquery\"],\"optional\":true,\"advanced\":true,\"description\":\"Cluster by\"}],\"version\":\"1.2\",\"label\":\"Join\"},\"type\":\"generic\",\"width\":64,\"height\":64,\"zIndex\":2,\"dragging\":false,\"position\":{\"x\":288,\"y\":32},\"selected\":false,\"positionAbsolute\":{\"x\":288,\"y\":32}},{\"id\":\"bbeecc5a-353a-4840-9481-ed610395413b\",\"data\":{\"name\":\"native.customsql\",\"title\":\"ADD GEOM\",\"inputs\":[{\"name\":\"sourcea\",\"type\":\"Table\",\"title\":\"Source table a\",\"optional\":true,\"description\":\"Source table a\"},{\"name\":\"sourceb\",\"type\":\"Table\",\"title\":\"Source table b\",\"optional\":true,\"description\":\"Source table b\"},{\"name\":\"sourcec\",\"type\":\"Table\",\"title\":\"Source table c\",\"optional\":true,\"description\":\"Source table c\"},{\"name\":\"sql\",\"type\":\"StringSql\",\"title\":\"SQL SELECT statement\",\"mode\":\"multiline\",\"placeholder\":\"SELECT ST_Centroid(geom) AS geom,\\n  AVG(value) AS average_value,\\n  category\\nFROM $a\\nGROUP BY category\",\"allowExpressions\":false,\"description\":\"SQL SELECT statement\",\"value\":\"SELECT * EXCEPT(geom_joined, longitude, latitude, block_joined, carto_geocode_metadata_joined), \\nCASE WHEN longitude IS NULL OR latitude IS NULL THEN geom_joined ELSE ST_GEOGPOINT(longitude, latitude) END AS geom\\nFROM `$a`\\n\"},{\"name\":\"optimizationcol\",\"type\":\"Column\",\"title\":\"Cluster by\",\"parent\":\"source\",\"parentOutput\":\"result\",\"dataType\":[\"geography\",\"boolean\",\"number\",\"string\",\"date\",\"datetime\",\"time\",\"timestamp\"],\"providers\":[\"bigquery\"],\"optional\":true,\"advanced\":true,\"description\":\"Cluster by\"}],\"version\":\"2.0.0\",\"label\":\"Custom SQL Select\"},\"type\":\"generic\",\"width\":64,\"height\":64,\"zIndex\":2,\"dragging\":false,\"position\":{\"x\":416,\"y\":48},\"selected\":false,\"positionAbsolute\":{\"x\":416,\"y\":48}},{\"id\":\"fc562c36-2bf2-45ab-91d3-296fbf4dbe26\",\"data\":{\"name\":\"native.customsql\",\"inputs\":[{\"name\":\"sourcea\",\"type\":\"Table\",\"title\":\"Source table a\",\"optional\":true,\"description\":\"Source table a\"},{\"name\":\"sourceb\",\"type\":\"Table\",\"title\":\"Source table b\",\"optional\":true,\"description\":\"Source table b\"},{\"name\":\"sourcec\",\"type\":\"Table\",\"title\":\"Source table c\",\"optional\":true,\"description\":\"Source table c\"},{\"name\":\"sql\",\"type\":\"StringSql\",\"title\":\"SQL SELECT statement\",\"mode\":\"multiline\",\"placeholder\":\"SELECT ST_Centroid(geom) AS geom,\\n  AVG(value) AS average_value,\\n  category\\nFROM $a\\nGROUP BY category\",\"allowExpressions\":false,\"description\":\"SQL SELECT statement\",\"value\":\"WITH acs_years AS (\\nSELECT acs_year\\nFROM `$b`\\n),\\nyears AS(\\nSELECT DISTINCT year\\nFROM `$a`\\n),\\ncross_join AS (\\nSELECT a.year AS year, \\nb.acs_year AS closest_year, \\nABS(a.year - b.acs_year) AS year_diff,\\nFROM years a\\nCROSS JOIN acs_years b\\n),\\nclosest_match AS(\\nSELECT *,\\nROW_NUMBER() OVER (PARTITION BY year ORDER BY year_diff) AS rn\\nFROM cross_join \\n)\\nSELECT\\n\\tyear,\\n    closest_year\\nFROM closest_match\\nWHERE rn = 1\"},{\"name\":\"optimizationcol\",\"type\":\"Column\",\"title\":\"Cluster by\",\"parent\":\"source\",\"parentOutput\":\"result\",\"dataType\":[\"geography\",\"boolean\",\"number\",\"string\",\"date\",\"datetime\",\"time\",\"timestamp\"],\"providers\":[\"bigquery\"],\"optional\":true,\"advanced\":true,\"description\":\"Cluster by\"}],\"version\":\"2.0.0\",\"label\":\"Custom SQL Select\"},\"type\":\"generic\",\"width\":64,\"height\":64,\"zIndex\":2,\"dragging\":true,\"position\":{\"x\":2096,\"y\":224},\"selected\":false,\"positionAbsolute\":{\"x\":2096,\"y\":224}},{\"id\":\"7cd1a42b-e688-4419-b70f-c273e9c43a9b\",\"data\":{\"name\":\"native.distinct\",\"inputs\":[{\"name\":\"source\",\"type\":\"Table\",\"title\":\"Source table\",\"description\":\"Source table\"},{\"name\":\"column\",\"type\":\"Column\",\"title\":\"Column\",\"parent\":\"source\",\"description\":\"Column\",\"value\":\"acs_year\",\"options\":[\"h3\",\"total_pop_sum\",\"median_age_avg\",\"median_rent_avg\",\"black_pop_sum\",\"hispanic_pop_sum\",\"owner_occupied_housing_units_median_value_sum\",\"vacant_housing_units_sum\",\"housing_units_sum\",\"families_with_young_children_sum\",\"acs_year\",\"urbanity_any\",\"urbanity_any_ordinal\",\"principal_component_1\",\"principal_component_2\"]},{\"name\":\"optimizationcol\",\"type\":\"Column\",\"title\":\"Cluster by\",\"parent\":\"source\",\"parentOutput\":\"result\",\"dataType\":[\"geography\",\"boolean\",\"number\",\"string\",\"date\",\"datetime\",\"time\",\"timestamp\"],\"providers\":[\"bigquery\"],\"optional\":true,\"advanced\":true,\"description\":\"Cluster by\",\"options\":[\"acs_year\"]}],\"version\":\"1\",\"label\":\"Select Distinct\"},\"type\":\"generic\",\"width\":64,\"height\":64,\"zIndex\":2,\"dragging\":false,\"position\":{\"x\":1920,\"y\":224},\"selected\":false,\"positionAbsolute\":{\"x\":1920,\"y\":224}},{\"id\":\"b40971a4-d394-411f-bc2c-6786f85dc072\",\"data\":{\"name\":\"native.selectexpression\",\"title\":\"CREATE YEAR COLUMN\",\"inputs\":[{\"name\":\"source\",\"type\":\"Table\",\"title\":\"Source table\",\"description\":\"Source table\"},{\"name\":\"column\",\"type\":\"String\",\"title\":\"Name for new column\",\"placeholder\":\"E.g.: distance_in_meters\",\"validation\":\"^[a-zA-Z_][a-zA-Z0-9_]*$\",\"allowExpressions\":false,\"description\":\"Name for new column\",\"value\":\"year\"},{\"name\":\"expression\",\"type\":\"StringSql\",\"title\":\"Expression\",\"placeholder\":\"E.g.: distance_in_km * 1000\",\"description\":\"Expression\",\"value\":\"EXTRACT(year FROM week)\"},{\"name\":\"optimizationcol\",\"type\":\"Column\",\"title\":\"Cluster by\",\"parent\":\"source\",\"parentOutput\":\"result\",\"dataType\":[\"geography\",\"boolean\",\"number\",\"string\",\"date\",\"datetime\",\"time\",\"timestamp\"],\"providers\":[\"bigquery\"],\"optional\":true,\"advanced\":true,\"description\":\"Cluster by\",\"value\":\"h3\",\"options\":[\"week\",\"h3\",\"counts\",\"year\"]}],\"version\":\"1\",\"label\":\"Create Column\"},\"type\":\"generic\",\"width\":64,\"height\":64,\"zIndex\":2,\"dragging\":false,\"position\":{\"x\":1712,\"y\":64},\"selected\":false,\"positionAbsolute\":{\"x\":1712,\"y\":64}},{\"id\":\"fd1e0d19-8622-4c70-95fd-99e0e2969fae\",\"data\":{\"name\":\"native.join\",\"inputs\":[{\"name\":\"maintable\",\"type\":\"Table\",\"title\":\"Main table\",\"description\":\"Main table\"},{\"name\":\"secondarytable\",\"type\":\"Table\",\"title\":\"Secondary table\",\"description\":\"Secondary table\"},{\"name\":\"maincolumn\",\"type\":\"Column\",\"title\":\"Column in main table\",\"parent\":\"maintable\",\"dataType\":[\"boolean\",\"date\",\"datetime\",\"time\",\"timestamp\",\"number\",\"string\"],\"description\":\"Column in main table\",\"value\":\"year\",\"options\":[\"week\",\"h3\",\"counts\",\"year\"]},{\"name\":\"secondarycolumn\",\"type\":\"Column\",\"title\":\"Column in secondary table\",\"parent\":\"secondarytable\",\"dataType\":[\"boolean\",\"date\",\"datetime\",\"time\",\"timestamp\",\"number\",\"string\"],\"description\":\"Column in secondary table\",\"value\":\"year\",\"options\":[\"year\",\"closest_year\"]},{\"name\":\"jointype\",\"type\":\"Selection\",\"title\":\"Join type\",\"options\":[\"Inner\",\"Left\",\"Right\",\"Full outer\"],\"default\":\"Inner\",\"description\":\"Join type\",\"value\":\"Inner\"},{\"name\":\"optimizationcol\",\"type\":\"Column\",\"title\":\"Cluster by\",\"parent\":\"source\",\"parentOutput\":\"result\",\"dataType\":[\"geography\",\"boolean\",\"number\",\"string\",\"date\",\"datetime\",\"time\",\"timestamp\"],\"providers\":[\"bigquery\"],\"optional\":true,\"advanced\":true,\"description\":\"Cluster by\"}],\"version\":\"1.2\",\"label\":\"Join\"},\"type\":\"generic\",\"width\":64,\"height\":64,\"zIndex\":2,\"dragging\":false,\"position\":{\"x\":2256,\"y\":80},\"selected\":false,\"positionAbsolute\":{\"x\":2256,\"y\":80}},{\"id\":\"50941775-9361-4c59-a7c1-f2fcd982607e\",\"data\":{\"name\":\"native.where\",\"title\":\"WHERE GEOM IS NOT NULL\",\"inputs\":[{\"name\":\"source\",\"type\":\"Table\",\"title\":\"Source table\",\"description\":\"Source table\"},{\"name\":\"expression\",\"type\":\"StringSql\",\"title\":\"Filter expression\",\"placeholder\":\"E.g.: area > 1000 AND area < 3000\",\"description\":\"Filter expression\",\"value\":\"geom IS NOT NULL\"},{\"name\":\"optimizationcol\",\"type\":\"Column\",\"title\":\"Cluster by\",\"parent\":\"source\",\"parentOutput\":\"match\",\"dataType\":[\"geography\",\"boolean\",\"number\",\"string\",\"date\",\"datetime\",\"time\",\"timestamp\"],\"providers\":[\"bigquery\"],\"optional\":true,\"advanced\":true,\"description\":\"Cluster by\",\"value\":\"geom\",\"options\":[\"unique_key\",\"date\",\"block\",\"primary_type\",\"geom\"]}],\"version\":\"1\",\"label\":\"Where\"},\"type\":\"generic\",\"width\":64,\"height\":64,\"zIndex\":2,\"dragging\":false,\"position\":{\"x\":592,\"y\":48},\"selected\":false,\"positionAbsolute\":{\"x\":592,\"y\":48}},{\"id\":\"b9a8d3b2-6fcc-43b6-84f6-734e1c931820\",\"data\":{\"name\":\"native.selectexpression\",\"title\":\"TRUNCATE DATE BY WEEK\",\"inputs\":[{\"name\":\"source\",\"type\":\"Table\",\"title\":\"Source table\",\"description\":\"Source table\"},{\"name\":\"column\",\"type\":\"String\",\"title\":\"Name for new column\",\"placeholder\":\"E.g.: distance_in_meters\",\"validation\":\"^[a-zA-Z_][a-zA-Z0-9_]*$\",\"allowExpressions\":false,\"description\":\"Name for new column\",\"value\":\"week\"},{\"name\":\"expression\",\"type\":\"StringSql\",\"title\":\"Expression\",\"placeholder\":\"E.g.: distance_in_km * 1000\",\"description\":\"Expression\",\"value\":\"DATE_TRUNC(date, WEEK(MONDAY))\"},{\"name\":\"optimizationcol\",\"type\":\"Column\",\"title\":\"Cluster by\",\"parent\":\"source\",\"parentOutput\":\"result\",\"dataType\":[\"geography\",\"boolean\",\"number\",\"string\",\"date\",\"datetime\",\"time\",\"timestamp\"],\"providers\":[\"bigquery\"],\"optional\":true,\"advanced\":true,\"description\":\"Cluster by\",\"value\":\"geom\",\"options\":[\"unique_key\",\"date\",\"block\",\"primary_type\",\"geom\",\"week\"]}],\"version\":\"1\",\"label\":\"Create Column\"},\"type\":\"generic\",\"width\":64,\"height\":64,\"zIndex\":2,\"dragging\":false,\"position\":{\"x\":816,\"y\":32},\"selected\":false,\"positionAbsolute\":{\"x\":816,\"y\":32}},{\"id\":\"8d6ad481-2189-47f7-a0a8-aeec055d8d5c\",\"data\":{\"name\":\"native.h3frompoint\",\"inputs\":[{\"name\":\"source\",\"type\":\"Table\",\"title\":\"Source table\",\"description\":\"Source table\"},{\"name\":\"pointscol\",\"type\":\"Column\",\"title\":\"Points column\",\"parent\":\"source\",\"dataType\":[\"geography\"],\"description\":\"Points column\",\"value\":\"geom\",\"options\":[\"geom\"]},{\"name\":\"resolution\",\"type\":\"Number\",\"title\":\"Resolution\",\"min\":0,\"max\":15,\"default\":8,\"mode\":\"slider\",\"description\":\"Resolution\",\"value\":7},{\"name\":\"optimizationcol\",\"type\":\"Column\",\"title\":\"Cluster by\",\"parent\":\"source\",\"parentOutput\":\"result\",\"dataType\":[\"geography\",\"boolean\",\"number\",\"string\",\"date\",\"datetime\",\"time\",\"timestamp\"],\"providers\":[\"bigquery\"],\"optional\":true,\"advanced\":true,\"description\":\"Cluster by\",\"value\":\"h3\",\"options\":[\"h3\",\"unique_key\",\"date\",\"block\",\"primary_type\",\"geom\",\"week\"]}],\"version\":\"1\",\"label\":\"H3 from GeoPoint\"},\"type\":\"generic\",\"width\":64,\"height\":64,\"zIndex\":2,\"dragging\":false,\"position\":{\"x\":1008,\"y\":32},\"selected\":false,\"positionAbsolute\":{\"x\":1008,\"y\":32}},{\"id\":\"127af41c-14b7-465a-86f1-26e288ae2ee2\",\"data\":{\"name\":\"native.groupby\",\"title\":\"COUNT BY H3 AND WEEK\",\"inputs\":[{\"name\":\"source\",\"type\":\"Table\",\"title\":\"Source table\",\"description\":\"Source table\"},{\"name\":\"columns\",\"type\":\"SelectColumnAggregation\",\"title\":\"Aggregation\",\"parent\":\"source\",\"placeholder\":\"workflows.parameterForm.selectAField\",\"allowExpression\":false,\"description\":\"Aggregation\",\"value\":\"unique_key,count\",\"options\":[\"h3\",\"unique_key\",\"date\",\"block\",\"primary_type\",\"geom\",\"week\"]},{\"name\":\"groupby\",\"type\":\"Column\",\"title\":\"Group by\",\"parent\":\"source\",\"mode\":\"multiple\",\"dataType\":[\"boolean\",\"number\",\"string\",\"date\",\"datetime\",\"time\",\"timestamp\"],\"noDefault\":true,\"maxSelectionsCount\":null,\"description\":\"Group by\",\"value\":[\"h3\",\"week\"],\"options\":[\"h3\",\"unique_key\",\"date\",\"block\",\"primary_type\",\"week\"]},{\"name\":\"optimizationcol\",\"type\":\"Column\",\"title\":\"Cluster by\",\"parent\":\"source\",\"parentOutput\":\"result\",\"dataType\":[\"geography\",\"boolean\",\"number\",\"string\",\"date\",\"datetime\",\"time\",\"timestamp\"],\"providers\":[\"bigquery\"],\"optional\":true,\"advanced\":true,\"description\":\"Cluster by\",\"value\":\"h3\",\"options\":[\"h3\",\"week\",\"unique_key_count\"]}],\"version\":\"1\",\"label\":\"Group by\"},\"type\":\"generic\",\"width\":64,\"height\":64,\"zIndex\":2,\"dragging\":false,\"position\":{\"x\":1184,\"y\":32},\"selected\":false,\"positionAbsolute\":{\"x\":1184,\"y\":32}},{\"id\":\"6f082e9d-0e8e-4c93-938f-5a4267bfa4f0\",\"data\":{\"name\":\"native.customsql\",\"title\":\"GAP FILLING\",\"inputs\":[{\"name\":\"sourcea\",\"type\":\"Table\",\"title\":\"Source table a\",\"optional\":true,\"description\":\"Source table a\"},{\"name\":\"sourceb\",\"type\":\"Table\",\"title\":\"Source table b\",\"optional\":true,\"description\":\"Source table b\"},{\"name\":\"sourcec\",\"type\":\"Table\",\"title\":\"Source table c\",\"optional\":true,\"description\":\"Source table c\"},{\"name\":\"sql\",\"type\":\"StringSql\",\"title\":\"SQL SELECT statement\",\"mode\":\"multiline\",\"placeholder\":\"SELECT ST_Centroid(geom) AS geom,\\n  AVG(value) AS average_value,\\n  category\\nFROM $a\\nGROUP BY category\",\"allowExpressions\":false,\"description\":\"SQL SELECT statement\",\"value\":\"WITH T1 AS(\\nSELECT h3, DATE(week) AS week, counts\\nFROM `$a` \\n),\\nT2 AS(\\nSELECT *\\nFROM GAP_FILL(\\nTABLE T1,\\nts_column => 'week',\\nbucket_width => INTERVAL 1 WEEK,\\npartitioning_columns => ['h3'],\\nignore_null_values => FALSE,\\nvalue_columns => [\\n('counts', 'null')\\n],\\norigin => DATE '2001-01-01'\\n)\\n)\\nSELECT * EXCEPT(counts), COALESCE(counts, 0) AS counts\\nFROM T2\"},{\"name\":\"optimizationcol\",\"type\":\"Column\",\"title\":\"Cluster by\",\"parent\":\"source\",\"parentOutput\":\"result\",\"dataType\":[\"geography\",\"boolean\",\"number\",\"string\",\"date\",\"datetime\",\"time\",\"timestamp\"],\"providers\":[\"bigquery\"],\"optional\":true,\"advanced\":true,\"description\":\"Cluster by\"}],\"version\":\"2.0.0\",\"label\":\"Custom SQL Select\"},\"type\":\"generic\",\"width\":64,\"height\":64,\"zIndex\":2,\"dragging\":false,\"position\":{\"x\":1552,\"y\":64},\"selected\":false,\"positionAbsolute\":{\"x\":1552,\"y\":64}},{\"id\":\"7ae102bf-068b-4700-aca2-4a9dcb67aa2f\",\"data\":{\"name\":\"native.dropcolumn\",\"inputs\":[{\"name\":\"source\",\"type\":\"Table\",\"title\":\"Source table\",\"description\":\"Source table\"},{\"name\":\"column\",\"type\":\"Column\",\"title\":\"Columns to drop\",\"parent\":\"source\",\"mode\":\"multiple\",\"noDefault\":true,\"description\":\"Columns to drop\",\"value\":[\"year_joined\"],\"options\":[\"week\",\"h3\",\"counts\",\"year\",\"year_joined\",\"closest_year_joined\"]},{\"name\":\"optimizationcol\",\"type\":\"Column\",\"title\":\"Cluster by\",\"parent\":\"source\",\"parentOutput\":\"result\",\"dataType\":[\"geography\",\"boolean\",\"number\",\"string\",\"date\",\"datetime\",\"time\",\"timestamp\"],\"providers\":[\"bigquery\"],\"optional\":true,\"advanced\":true,\"description\":\"Cluster by\",\"value\":\"h3\",\"options\":[\"week\",\"h3\",\"counts\",\"year\",\"closest_year_joined\"]}],\"version\":\"1\",\"label\":\"Drop Columns\"},\"type\":\"generic\",\"width\":64,\"height\":64,\"zIndex\":2,\"dragging\":false,\"position\":{\"x\":2384,\"y\":80},\"selected\":false,\"positionAbsolute\":{\"x\":2384,\"y\":80}},{\"id\":\"01a665bd-7166-403e-89c5-776014f70ed0\",\"data\":{\"name\":\"native.selectexpression\",\"title\":\"ADD SEASON\",\"inputs\":[{\"name\":\"source\",\"type\":\"Table\",\"title\":\"Source table\",\"description\":\"Source table\"},{\"name\":\"column\",\"type\":\"String\",\"title\":\"Name for new column\",\"placeholder\":\"E.g.: distance_in_meters\",\"validation\":\"^[a-zA-Z_][a-zA-Z0-9_]*$\",\"allowExpressions\":false,\"description\":\"Name for new column\",\"value\":\"month\"},{\"name\":\"expression\",\"type\":\"StringSql\",\"title\":\"Expression\",\"placeholder\":\"E.g.: distance_in_km * 1000\",\"description\":\"Expression\",\"value\":\"EXTRACT(MONTH FROM week)\"},{\"name\":\"optimizationcol\",\"type\":\"Column\",\"title\":\"Cluster by\",\"parent\":\"source\",\"parentOutput\":\"result\",\"dataType\":[\"geography\",\"boolean\",\"number\",\"string\",\"date\",\"datetime\",\"time\",\"timestamp\"],\"providers\":[\"bigquery\"],\"optional\":true,\"advanced\":true,\"description\":\"Cluster by\",\"value\":\"h3\",\"options\":[\"week\",\"h3\",\"counts\",\"year\",\"closest_year_joined\",\"month\"]}],\"version\":\"1\",\"label\":\"Create Column\"},\"type\":\"generic\",\"width\":64,\"height\":64,\"zIndex\":2,\"dragging\":false,\"position\":{\"x\":2544,\"y\":80},\"selected\":false,\"positionAbsolute\":{\"x\":2544,\"y\":80}},{\"id\":\"6071942b-e04d-4e45-9952-c90ce75f843b\",\"data\":{\"name\":\"native.saveastable\",\"inputs\":[{\"name\":\"source\",\"type\":\"Table\",\"title\":\"Source table\",\"description\":\"Source table\"},{\"name\":\"destination\",\"type\":\"OutputTable\",\"title\":\"Table details\",\"placeholder\":\"Rename and select destination\",\"description\":\"Table details\",\"value\":\"cartobq.sdsc24_ny_workshops.CHI_boundary_enriched\"},{\"name\":\"append\",\"type\":\"Boolean\",\"title\":\"Append to existing table\",\"default\":false,\"description\":\"Append to existing table\",\"value\":false},{\"name\":\"optimizationcol\",\"type\":\"Column\",\"title\":\"Cluster by\",\"parent\":\"source\",\"parentOutput\":\"result\",\"dataType\":[\"geography\",\"boolean\",\"number\",\"string\",\"date\",\"datetime\",\"time\",\"timestamp\"],\"providers\":[\"bigquery\"],\"optional\":true,\"advanced\":true,\"description\":\"Cluster by\",\"value\":\"h3\",\"options\":[\"week\",\"h3\",\"counts\",\"year\",\"month\",\"total_pop_sum\",\"median_age_avg\",\"median_rent_avg\",\"black_pop_sum\",\"hispanic_pop_sum\",\"owner_occupied_housing_units_median_value_sum\",\"vacant_housing_units_sum\",\"housing_units_sum\",\"families_with_young_children_sum\",\"urbanity_any\",\"urbanity_any_ordinal\",\"principal_component_1\",\"principal_component_2\"]}],\"version\":\"1\",\"label\":\"Save as Table\"},\"type\":\"generic\",\"width\":64,\"height\":64,\"zIndex\":2,\"dragging\":false,\"position\":{\"x\":2976,\"y\":304},\"selected\":false,\"positionAbsolute\":{\"x\":2976,\"y\":304}},{\"id\":\"088f73e9-307a-44c6-a66f-d1da05ebf53e\",\"data\":{\"name\":\"native.customsql\",\"title\":\"ADD MIN-MAX dates\",\"inputs\":[{\"name\":\"sourcea\",\"type\":\"Table\",\"title\":\"Source table a\",\"optional\":true,\"description\":\"Source table a\"},{\"name\":\"sourceb\",\"type\":\"Table\",\"title\":\"Source table b\",\"optional\":true,\"description\":\"Source table b\"},{\"name\":\"sourcec\",\"type\":\"Table\",\"title\":\"Source table c\",\"optional\":true,\"description\":\"Source table c\"},{\"name\":\"sql\",\"type\":\"StringSql\",\"title\":\"SQL SELECT statement\",\"mode\":\"multiline\",\"placeholder\":\"SELECT ST_Centroid(geom) AS geom,\\n  AVG(value) AS average_value,\\n  category\\nFROM $a\\nGROUP BY category\",\"allowExpressions\":false,\"description\":\"SQL SELECT statement\",\"value\":\"WITH base_data AS (\\nSELECT week, h3, COALESCE(unique_key_count, 0) AS counts\\nFROM `$a`\\n),\\nmin_max_dates AS (\\nSELECT\\nh3,\\nMIN(week) OVER() AS min_date,\\nMAX(week) OVER() AS max_date\\nFROM base_data\\n),\\nmin_dates_missing AS (\\nSELECT\\nmin_max_dates.h3,\\nmin_date AS week\\nFROM min_max_dates\\nLEFT JOIN base_data\\nON min_max_dates.h3 = base_data.h3 AND min_max_dates.min_date = base_data.week\\nWHERE base_data.week IS NULL\\n),\\nmax_dates_missing AS (\\nSELECT\\nmin_max_dates.h3,\\nmax_date AS week\\nFROM min_max_dates\\nLEFT JOIN base_data\\nON min_max_dates.h3 = base_data.h3 AND min_max_dates.max_date = base_data.week\\nWHERE base_data.week IS NULL\\n),\\nmin_max_data AS (\\n(\\nSELECT week, h3, counts\\nFROM base_data\\n)\\nUNION ALL\\n(\\nSELECT week, h3, 0 AS counts\\nFROM min_dates_missing\\n)\\nUNION ALL\\n(\\nSELECT week, h3, 0 AS counts\\nFROM max_dates_missing\\n))\\nSELECT *\\nFROM min_max_data\\n\"},{\"name\":\"optimizationcol\",\"type\":\"Column\",\"title\":\"Cluster by\",\"parent\":\"source\",\"parentOutput\":\"result\",\"dataType\":[\"geography\",\"boolean\",\"number\",\"string\",\"date\",\"datetime\",\"time\",\"timestamp\"],\"providers\":[\"bigquery\"],\"optional\":true,\"advanced\":true,\"description\":\"Cluster by\"}],\"version\":\"2.0.0\",\"label\":\"Custom SQL Select\"},\"type\":\"generic\",\"width\":64,\"height\":64,\"zIndex\":2,\"dragging\":false,\"position\":{\"x\":1408,\"y\":48},\"selected\":false,\"positionAbsolute\":{\"x\":1408,\"y\":48}},{\"id\":\"be8e5b12-ec46-4b17-81b0-e341acdb13f6\",\"data\":{\"name\":\"native.customsql\",\"title\":\"CUSTOM JOIN\",\"inputs\":[{\"name\":\"sourcea\",\"type\":\"Table\",\"title\":\"Source table a\",\"optional\":true,\"description\":\"Source table a\"},{\"name\":\"sourceb\",\"type\":\"Table\",\"title\":\"Source table b\",\"optional\":true,\"description\":\"Source table b\"},{\"name\":\"sourcec\",\"type\":\"Table\",\"title\":\"Source table c\",\"optional\":true,\"description\":\"Source table c\"},{\"name\":\"sql\",\"type\":\"StringSql\",\"title\":\"SQL SELECT statement\",\"mode\":\"multiline\",\"placeholder\":\"SELECT ST_Centroid(geom) AS geom,\\n  AVG(value) AS average_value,\\n  category\\nFROM $a\\nGROUP BY category\",\"allowExpressions\":false,\"description\":\"SQL SELECT statement\",\"value\":\"SELECT a.* EXCEPT(closest_year_joined), b.* EXCEPT(h3, acs_year)\\nFROM `$a`AS a\\nJOIN `$b`AS b\\nON a.h3 = b.h3 AND a.closest_year_joined = b.acs_year\"},{\"name\":\"optimizationcol\",\"type\":\"Column\",\"title\":\"Cluster by\",\"parent\":\"source\",\"parentOutput\":\"result\",\"dataType\":[\"geography\",\"boolean\",\"number\",\"string\",\"date\",\"datetime\",\"time\",\"timestamp\"],\"providers\":[\"bigquery\"],\"optional\":true,\"advanced\":true,\"description\":\"Cluster by\"}],\"version\":\"2.0.0\",\"label\":\"Custom SQL Select\"},\"type\":\"generic\",\"width\":64,\"height\":64,\"zIndex\":2,\"dragging\":false,\"position\":{\"x\":2736,\"y\":496},\"selected\":false,\"positionAbsolute\":{\"x\":2736,\"y\":496}},{\"id\":\"6ea8981c-57a6-4ca9-9740-153121408a60\",\"data\":{\"id\":\"cartobq.sdsc24_ny_workshops.CHI_boundary_enriched_w_ACS_2007_2020_w_pc_scores\",\"name\":\"ReadTable\",\"size\":82020,\"type\":\"table\",\"label\":\"CHI_boundary_enriched_w_ACS_2007_2020_w_pc_scores\",\"nrows\":575,\"inputs\":[{\"name\":\"source\",\"type\":\"String\",\"title\":\"Source table\",\"value\":\"cartobq.sdsc24_ny_workshops.CHI_boundary_enriched_w_ACS_2007_2020_w_pc_scores\",\"description\":\"Read Table\"}],\"schema\":[{\"name\":\"h3\",\"type\":\"string\"},{\"name\":\"total_pop_sum\",\"type\":\"number\"},{\"name\":\"median_age_avg\",\"type\":\"number\"},{\"name\":\"median_rent_avg\",\"type\":\"number\"},{\"name\":\"black_pop_sum\",\"type\":\"number\"},{\"name\":\"hispanic_pop_sum\",\"type\":\"number\"},{\"name\":\"owner_occupied_housing_units_median_value_sum\",\"type\":\"number\"},{\"name\":\"vacant_housing_units_sum\",\"type\":\"number\"},{\"name\":\"housing_units_sum\",\"type\":\"number\"},{\"name\":\"families_with_young_children_sum\",\"type\":\"number\"},{\"name\":\"acs_year\",\"type\":\"number\"},{\"name\":\"urbanity_any\",\"type\":\"string\"},{\"name\":\"urbanity_any_ordinal\",\"type\":\"number\"},{\"name\":\"principal_component_1\",\"type\":\"number\"},{\"name\":\"principal_component_2\",\"type\":\"number\"}],\"enriched\":true,\"provider\":\"bigquery\",\"geomField\":\"h3:h3\",\"tableRegion\":\"US\",\"lastModified\":1726221115234,\"optimization\":{\"actions\":[{\"type\":\"cluster\",\"enabled\":false}],\"actionAvailable\":{\"msg\":\"<b>This table isn't optimized.</b> Creating a cluster based on geospatial data may improve performance.\",\"type\":\"createTable\",\"query\":\"CREATE TABLE {newTableName} CLUSTER BY h3 AS SELECT * FROM `cartobq.sdsc24_ny_workshops.CHI_boundary_enriched_w_ACS_2007_2020_w_pc_scores`\"}},\"originalSchema\":[{\"name\":\"h3\",\"type\":\"STRING\"},{\"name\":\"total_pop_sum\",\"type\":\"FLOAT\"},{\"name\":\"median_age_avg\",\"type\":\"FLOAT\"},{\"name\":\"median_rent_avg\",\"type\":\"FLOAT\"},{\"name\":\"black_pop_sum\",\"type\":\"FLOAT\"},{\"name\":\"hispanic_pop_sum\",\"type\":\"FLOAT\"},{\"name\":\"owner_occupied_housing_units_median_value_sum\",\"type\":\"FLOAT\"},{\"name\":\"vacant_housing_units_sum\",\"type\":\"FLOAT\"},{\"name\":\"housing_units_sum\",\"type\":\"FLOAT\"},{\"name\":\"families_with_young_children_sum\",\"type\":\"FLOAT\"},{\"name\":\"acs_year\",\"type\":\"INTEGER\"},{\"name\":\"urbanity_any\",\"type\":\"STRING\"},{\"name\":\"urbanity_any_ordinal\",\"type\":\"INTEGER\"},{\"name\":\"principal_component_1\",\"type\":\"FLOAT\"},{\"name\":\"principal_component_2\",\"type\":\"FLOAT\"}]},\"type\":\"source\",\"width\":192,\"height\":64,\"zIndex\":2,\"dragging\":false,\"position\":{\"x\":-672,\"y\":528},\"selected\":false,\"positionAbsolute\":{\"x\":-672,\"y\":528}},{\"id\":\"c5fe1752-1ca3-42f8-aa37-03f0c661fccc\",\"data\":{\"name\":\"Note\",\"color\":\"#8BE0A4\",\"genAi\":false,\"label\":\"\",\"width\":495.999,\"height\":735.995,\"inputs\":[],\"markdown\":\"---\\nlabel:\\n---\\n## Input data\",\"position\":{\"x\":-912.001,\"y\":-86.448}},\"type\":\"note\",\"width\":496,\"height\":736,\"zIndex\":-1,\"dragging\":false,\"position\":{\"x\":-784,\"y\":-64},\"selected\":false,\"positionAbsolute\":{\"x\":-784,\"y\":-64}},{\"id\":\"c5fe1752-1ca3-42f8-aa37-03f0c661fccc-1726222098263\",\"data\":{\"name\":\"Note\",\"color\":\"#F89C74\",\"genAi\":false,\"label\":\"\",\"width\":3136,\"height\":735.995,\"inputs\":[],\"markdown\":\"---\\nlabel:\\n---\\n## Pre-processing TS data\",\"position\":{\"x\":-272,\"y\":-64}},\"type\":\"note\",\"width\":3744,\"height\":736,\"zIndex\":-1,\"dragging\":false,\"position\":{\"x\":-272,\"y\":-64},\"selected\":false,\"positionAbsolute\":{\"x\":-272,\"y\":-64}},{\"id\":\"ad17f52d-08ec-464d-8fb1-ee586f232a74\",\"data\":{\"name\":\"Note\",\"color\":\"#FE88B1\",\"genAi\":false,\"label\":\"\",\"width\":320,\"height\":736,\"inputs\":[],\"markdown\":\"---\\nlabel:\\n---\\n## Save results to a table\",\"position\":{\"x\":3376,\"y\":-80}},\"type\":\"note\",\"width\":320,\"height\":736,\"zIndex\":-1,\"dragging\":false,\"position\":{\"x\":2880,\"y\":-64},\"selected\":false,\"positionAbsolute\":{\"x\":2880,\"y\":-64}},{\"id\":\"c5fe1752-1ca3-42f8-aa37-03f0c661fccc-1727093087139\",\"data\":{\"name\":\"Note\",\"color\":\"#8BE0A4\",\"genAi\":false,\"label\":\"\",\"width\":463.999,\"height\":367.995,\"inputs\":[],\"markdown\":\"---\\nlabel: Chicago Crime Data from BigQuery public martekeplace\\n---\\nThis dataset reflects reported incidents of crime (with the exception of murders where data exists for each victim) that occurred in the City of Chicago from 2001 to present, minus the most recent seven days. Data is extracted from the Chicago Police Department's CLEAR (Citizen Law Enforcement Analysis and Reporting) system. In order to protect the privacy of crime victims, addresses are shown at the block level only and specific locations are not identified.\",\"position\":{\"x\":-784,\"y\":16}},\"type\":\"note\",\"width\":464,\"height\":368,\"zIndex\":-1,\"dragging\":false,\"position\":{\"x\":-768,\"y\":16},\"selected\":false,\"positionAbsolute\":{\"x\":-768,\"y\":16}},{\"id\":\"c5fe1752-1ca3-42f8-aa37-03f0c661fccc-1727093087139-1727093212681\",\"data\":{\"name\":\"Note\",\"color\":\"#8BE0A4\",\"genAi\":false,\"label\":\"\",\"width\":463.993,\"height\":207.997,\"inputs\":[],\"markdown\":\"---\\nlabel: Chicago boundary enriched and pre-processed (FAMD) data\\n---\\n\",\"position\":{\"x\":-784,\"y\":447.995}},\"type\":\"note\",\"width\":464,\"height\":208,\"zIndex\":-1,\"dragging\":false,\"position\":{\"x\":-768,\"y\":448},\"selected\":false,\"positionAbsolute\":{\"x\":-768,\"y\":448}},{\"id\":\"4d784724-ab07-4093-adfb-ea451f4c374f\",\"data\":{\"name\":\"Note\",\"color\":\"#F89C74\",\"genAi\":false,\"label\":\"\",\"width\":976,\"height\":383.997,\"inputs\":[],\"markdown\":\"---\\nlabel: Geocode data for w/o lon/lat\\n---\\n\",\"position\":{\"x\":-240,\"y\":3.336}},\"type\":\"note\",\"width\":1379,\"height\":211,\"zIndex\":-1,\"dragging\":false,\"position\":{\"x\":-240,\"y\":160},\"selected\":false,\"positionAbsolute\":{\"x\":-240,\"y\":160}},{\"id\":\"4d784724-ab07-4093-adfb-ea451f4c374f-1727355772092\",\"data\":{\"name\":\"Note\",\"color\":\"#F89C74\",\"genAi\":false,\"label\":\"\",\"width\":576,\"height\":383.995,\"inputs\":[],\"markdown\":\"---\\nlabel: Group counts by week\\n---\\n\",\"position\":{\"x\":752,\"y\":0}},\"type\":\"note\",\"width\":976,\"height\":384,\"zIndex\":-1,\"dragging\":false,\"position\":{\"x\":752,\"y\":0},\"selected\":false,\"positionAbsolute\":{\"x\":752,\"y\":0}},{\"id\":\"4d784724-ab07-4093-adfb-ea451f4c374f-1727355772092-1727355784032\",\"data\":{\"name\":\"Note\",\"color\":\"#F89C74\",\"genAi\":false,\"label\":\"\",\"width\":496,\"height\":383.997,\"inputs\":[],\"markdown\":\"---\\nlabel: Filling missing dates w/ zeros\\n---\\n\",\"position\":{\"x\":1344,\"y\":0}},\"type\":\"note\",\"width\":576,\"height\":384,\"zIndex\":-1,\"dragging\":false,\"position\":{\"x\":1344,\"y\":0},\"selected\":false,\"positionAbsolute\":{\"x\":1344,\"y\":0}},{\"id\":\"4d784724-ab07-4093-adfb-ea451f4c374f-1727355772092-1727355784032-1727355798240\",\"data\":{\"name\":\"Note\",\"color\":\"#F89C74\",\"genAi\":false,\"label\":\"\",\"width\":992,\"height\":623.995,\"inputs\":[],\"markdown\":\"---\\nlabel: Join with the enriched data\\n---\\n\",\"position\":{\"x\":1856,\"y\":0}},\"type\":\"note\",\"width\":496,\"height\":384,\"zIndex\":-1,\"dragging\":false,\"position\":{\"x\":1856,\"y\":0},\"selected\":false,\"positionAbsolute\":{\"x\":1856,\"y\":0}}],\"title\":\"(3/) SDSC24 - Unlocking Smarter Property Risk Assessments with Spatio-Temporal Crime Insights and CARTO\",\"useCache\":false,\"viewport\":{\"x\":355.16920446604445,\"y\":77.83361891127657,\"zoom\":0.24896243827361614},\"description\":\"\",\"thumbnailUrl\":\"\",\"schemaVersion\":\"1.0.0\",\"connectionProvider\":\"bigquery\"}"}
  */
  BEGIN
  CREATE TEMPORARY TABLE `WORKFLOW_54fd994649546936_c66521a11d5dac32_result`
  AS
    SELECT 
        unique_key,
        date,
        block,
        longitude,
        latitude,
        primary_type,
    FROM `bigquery-public-data.chicago_crime.crime`
    WHERE (LOWER(description) LIKE '%aggravated%' OR LOWER(description) LIKE '%murder%' ) AND LOWER(description) NOT LIKE '%non-aggravated%';
  END;
  BEGIN
  CREATE TEMPORARY TABLE `WORKFLOW_54fd994649546936_c3bc9056afecc34a_match`
  AS
    SELECT *
    FROM `WORKFLOW_54fd994649546936_c66521a11d5dac32_result`
    WHERE longitude IS NULL OR latitude IS NULL;
  END;
  BEGIN
  CREATE TEMPORARY TABLE `WORKFLOW_54fd994649546936_b22be74f6743c39e_result`
  AS
    SELECT DISTINCT(CONCAT(block, ', Chicago, IL')) AS block
    FROM `WORKFLOW_54fd994649546936_c3bc9056afecc34a_match`;
  END;
  BEGIN
  CREATE TEMPORARY TABLE `WORKFLOW_54fd994649546936_4384d387050c22ca_tempgeocoding`
  AS
    SELECT * FROM  `WORKFLOW_54fd994649546936_b22be74f6743c39e_result`;
  CALL `carto-un.carto`.GEOCODE_TABLE(
    'https://gcp-us-east1.api.carto.com',
    'eyJhbGciOiJIUzI1NiJ9.eyJhIjoiYWNfbHFlM3p3Z3UiLCJqdGkiOiI0OTBkNjkxYyJ9.Qf5j3DcqGFKmbsIl0uUOgQRP64sPsXhBO54zOqJzLxA',
    'WORKFLOW_54fd994649546936_4384d387050c22ca_tempgeocoding',
    'block',
    'geom',
    'US',
    NULL);
  CREATE TEMPORARY TABLE `WORKFLOW_54fd994649546936_4384d387050c22ca_match`
  AS
    SELECT * FROM  `WORKFLOW_54fd994649546936_4384d387050c22ca_tempgeocoding` WHERE geom IS NOT NULL;
  CREATE TEMPORARY TABLE `WORKFLOW_54fd994649546936_4384d387050c22ca_unmatch`
  AS
    SELECT * FROM  `WORKFLOW_54fd994649546936_4384d387050c22ca_tempgeocoding` WHERE geom IS NULL;
  END;
  BEGIN
  DECLARE alias STRING;
  CREATE TABLE `cartodb-on-gcp-datascience.workflows_temp.table_16a27b85_fdd2_4c76_936a_80f7c42fb092` AS
  SELECT * FROM `WORKFLOW_54fd994649546936_4384d387050c22ca_match`
  WHERE 1=0;
  EXECUTE IMMEDIATE
  '''
    with __alias AS(
      SELECT CONCAT(
        '_joined.', column_name, ' AS ', column_name, '_joined'
      ) col_alias
      FROM `cartodb-on-gcp-datascience.workflows_temp`.INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'table_16a27b85_fdd2_4c76_936a_80f7c42fb092'
    )
    SELECT STRING_AGG(col_alias, ', ')
    FROM __alias
  '''
  INTO alias;
  DROP TABLE `cartodb-on-gcp-datascience.workflows_temp.table_16a27b85_fdd2_4c76_936a_80f7c42fb092`;
  EXECUTE IMMEDIATE
  REPLACE(
    '''CREATE TEMPORARY TABLE `WORKFLOW_54fd994649546936_bda019f1f04e4480_result`
    AS
      SELECT
        _main.*,
        %s
      FROM
        `WORKFLOW_54fd994649546936_c66521a11d5dac32_result` AS _main
        LEFT JOIN
        `WORKFLOW_54fd994649546936_4384d387050c22ca_match` AS _joined
      ON
        _main.block = _joined.block''',
    '%s',
    alias
  );
  END;
  BEGIN
  CREATE TEMPORARY TABLE `WORKFLOW_54fd994649546936_bbc1674475c38a14_result`
  AS
    SELECT * EXCEPT(geom_joined, longitude, latitude, block_joined, carto_geocode_metadata_joined), 
    CASE WHEN longitude IS NULL OR latitude IS NULL THEN geom_joined ELSE ST_GEOGPOINT(longitude, latitude) END AS geom
    FROM `WORKFLOW_54fd994649546936_bda019f1f04e4480_result`;
  END;
  BEGIN
  CREATE TEMPORARY TABLE `WORKFLOW_54fd994649546936_a725c67bdd7cd803_match`
  CLUSTER BY geom
  AS
    SELECT *
    FROM `WORKFLOW_54fd994649546936_bbc1674475c38a14_result`
    WHERE geom IS NOT NULL;
  END;
  BEGIN
  CREATE TEMPORARY TABLE `WORKFLOW_54fd994649546936_957b5d93d5f51bc9_result`
  CLUSTER BY geom
  AS
    SELECT *,
      DATE_TRUNC(date, WEEK(MONDAY)) AS week
    FROM `WORKFLOW_54fd994649546936_a725c67bdd7cd803_match`;
  END;
  BEGIN
  CREATE TEMPORARY TABLE `WORKFLOW_54fd994649546936_ce3c2ec47bb898ac_result`
  CLUSTER BY h3
  AS
    SELECT
    `carto-un.carto`.H3_FROMGEOGPOINT(
        geom, 7
      ) h3, *
    FROM `WORKFLOW_54fd994649546936_957b5d93d5f51bc9_result`;
  END;
  BEGIN
  CREATE TEMPORARY TABLE `WORKFLOW_54fd994649546936_f2f22d7d0e228252_result`
  CLUSTER BY h3
  AS
    SELECT h3,
    week,
      COUNT(unique_key) unique_key_count
    FROM `WORKFLOW_54fd994649546936_ce3c2ec47bb898ac_result`
    GROUP BY h3,
    week;
  END;
  BEGIN
  CREATE TEMPORARY TABLE `WORKFLOW_54fd994649546936_cefdc34f705578ec_result`
  AS
    WITH base_data AS (
    SELECT week, h3, COALESCE(unique_key_count, 0) AS counts
    FROM `WORKFLOW_54fd994649546936_f2f22d7d0e228252_result`
    ),
    min_max_dates AS (
    SELECT
    h3,
    MIN(week) OVER() AS min_date,
    MAX(week) OVER() AS max_date
    FROM base_data
    ),
    min_dates_missing AS (
    SELECT
    min_max_dates.h3,
    min_date AS week
    FROM min_max_dates
    LEFT JOIN base_data
    ON min_max_dates.h3 = base_data.h3 AND min_max_dates.min_date = base_data.week
    WHERE base_data.week IS NULL
    ),
    max_dates_missing AS (
    SELECT
    min_max_dates.h3,
    max_date AS week
    FROM min_max_dates
    LEFT JOIN base_data
    ON min_max_dates.h3 = base_data.h3 AND min_max_dates.max_date = base_data.week
    WHERE base_data.week IS NULL
    ),
    min_max_data AS (
    (
    SELECT week, h3, counts
    FROM base_data
    )
    UNION ALL
    (
    SELECT week, h3, 0 AS counts
    FROM min_dates_missing
    )
    UNION ALL
    (
    SELECT week, h3, 0 AS counts
    FROM max_dates_missing
    ))
    SELECT *
    FROM min_max_data;
  END;
  BEGIN
  CREATE TEMPORARY TABLE `WORKFLOW_54fd994649546936_1c60c575fcd6c701_result`
  AS
    WITH T1 AS(
    SELECT h3, DATE(week) AS week, counts
    FROM `WORKFLOW_54fd994649546936_cefdc34f705578ec_result` 
    ),
    T2 AS(
    SELECT *
    FROM GAP_FILL(
    TABLE T1,
    ts_column => 'week',
    bucket_width => INTERVAL 1 WEEK,
    partitioning_columns => ['h3'],
    ignore_null_values => FALSE,
    value_columns => [
    ('counts', 'null')
    ],
    origin => DATE '2001-01-01'
    )
    )
    SELECT * EXCEPT(counts), COALESCE(counts, 0) AS counts
    FROM T2;
  END;
  BEGIN
  CREATE TEMPORARY TABLE `WORKFLOW_54fd994649546936_9735362ed1814ca0_result`
  CLUSTER BY h3
  AS
    SELECT *,
      EXTRACT(year FROM week) AS year
    FROM `WORKFLOW_54fd994649546936_1c60c575fcd6c701_result`;
  END;
  BEGIN
  CREATE TEMPORARY TABLE `WORKFLOW_54fd994649546936_427725b3477b7f22_result`
  AS
    SELECT DISTINCT acs_year
    FROM `cartobq.sdsc24_ny_workshops.CHI_boundary_enriched_w_ACS_2007_2020_w_pc_scores`;
  END;
  BEGIN
  CREATE TEMPORARY TABLE `WORKFLOW_54fd994649546936_8c2f5ee3416cae68_result`
  AS
    WITH acs_years AS (
    SELECT acs_year
    FROM `WORKFLOW_54fd994649546936_427725b3477b7f22_result`
    ),
    years AS(
    SELECT DISTINCT year
    FROM `WORKFLOW_54fd994649546936_9735362ed1814ca0_result`
    ),
    cross_join AS (
    SELECT a.year AS year, 
    b.acs_year AS closest_year, 
    ABS(a.year - b.acs_year) AS year_diff,
    FROM years a
    CROSS JOIN acs_years b
    ),
    closest_match AS(
    SELECT *,
    ROW_NUMBER() OVER (PARTITION BY year ORDER BY year_diff) AS rn
    FROM cross_join 
    )
    SELECT
    	year,
        closest_year
    FROM closest_match
    WHERE rn = 1;
  END;
  BEGIN
  DECLARE alias STRING;
  CREATE TABLE `cartodb-on-gcp-datascience.workflows_temp.table_9e2033a0_8628_4f0e_a71b_503e4c281f7c` AS
  SELECT * FROM `WORKFLOW_54fd994649546936_8c2f5ee3416cae68_result`
  WHERE 1=0;
  EXECUTE IMMEDIATE
  '''
    with __alias AS(
      SELECT CONCAT(
        '_joined.', column_name, ' AS ', column_name, '_joined'
      ) col_alias
      FROM `cartodb-on-gcp-datascience.workflows_temp`.INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = 'table_9e2033a0_8628_4f0e_a71b_503e4c281f7c'
    )
    SELECT STRING_AGG(col_alias, ', ')
    FROM __alias
  '''
  INTO alias;
  DROP TABLE `cartodb-on-gcp-datascience.workflows_temp.table_9e2033a0_8628_4f0e_a71b_503e4c281f7c`;
  EXECUTE IMMEDIATE
  REPLACE(
    '''CREATE TEMPORARY TABLE `WORKFLOW_54fd994649546936_81e770f4467e012d_result`
    AS
      SELECT
        _main.*,
        %s
      FROM
        `WORKFLOW_54fd994649546936_9735362ed1814ca0_result` AS _main
        INNER JOIN
        `WORKFLOW_54fd994649546936_8c2f5ee3416cae68_result` AS _joined
      ON
        _main.year = _joined.year''',
    '%s',
    alias
  );
  END;
  BEGIN
  CREATE TEMPORARY TABLE `WORKFLOW_54fd994649546936_56ee2510381f985c_result`
  CLUSTER BY h3
  AS
    SELECT * EXCEPT (year_joined)
    FROM `WORKFLOW_54fd994649546936_81e770f4467e012d_result`;
  END;
  BEGIN
  CREATE TEMPORARY TABLE `WORKFLOW_54fd994649546936_32733ac200d822bd_result`
  CLUSTER BY h3
  AS
    SELECT *,
      EXTRACT(MONTH FROM week) AS month
    FROM `WORKFLOW_54fd994649546936_56ee2510381f985c_result`;
  END;
  BEGIN
  CREATE TEMPORARY TABLE `WORKFLOW_54fd994649546936_29853809f0c72561_result`
  AS
    SELECT a.* EXCEPT(closest_year_joined), b.* EXCEPT(h3, acs_year)
    FROM `WORKFLOW_54fd994649546936_32733ac200d822bd_result`AS a
    JOIN `cartobq.sdsc24_ny_workshops.CHI_boundary_enriched_w_ACS_2007_2020_w_pc_scores`AS b
    ON a.h3 = b.h3 AND a.closest_year_joined = b.acs_year;
  END;
  BEGIN
  DROP TABLE IF EXISTS `cartobq.sdsc24_ny_workshops.CHI_boundary_enriched`;
  CREATE TABLE IF NOT EXISTS `cartobq.sdsc24_ny_workshops.CHI_boundary_enriched`
  CLUSTER BY h3
  AS
    SELECT * FROM `WORKFLOW_54fd994649546936_29853809f0c72561_result`;
  END;
END;