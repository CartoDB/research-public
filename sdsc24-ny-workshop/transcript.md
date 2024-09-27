# SDSC24 New York - Unlocking Smarter Property Risk Assessments with Spatio-Temporal Crime Insights and CARTO

---

**Note**: all the SQL queries are expected to be run in the BigQuery console or CARTO Data Warehouse console. If you are running a trial, you can find the steps to access your console in the [CARTO Data Warehouse documentation](https://docs.carto.com/carto-user-manual/connections/carto-data-warehouse).

## Presenting the Workshop

Spatial Data Science is all about using methods and tools where location and time are key elements of the data. In this tutorial, we'll dive into working with large spatio-temporal datasets, tackling the unique challenges they present in data engineering, visualization, and statistical modeling.

We'll get hands-on with CARTO, showing you how to analyze the patterns and changes in violent crimes over time and space.  Crime data is often an overlooked component in property risk assessments and rarely integrated into underwriting guidelines, despite the FBI's latest estimates indicating over $16 billion in losses annually from property crimes only.

More broadly, this practical session will help you see how insurers can use the results from this analysis to  improve portfolio management by better assessing non-financial, location-based risks related to not just crime, but also to other perils, like floods, hurricanes, hail.

Three key takeaways: 
- How to take advantage of large scale distributed computing technologies to process, visualize, and analyze spatio-temporal big data
- Using CARTO to model the spatial distribution and temporal evolution of complex datasets for real-world applications
- Using CARTO to create workflows and visualizations that provide decision-makers with easy access to critical insights

The workshop will be run using [CARTO Workflows](https://carto.com/workflows) and the [Goole Cloud Platform](https://cloud.google.com/). For CARTO newbies, Workflows is CARTO’s no-code / low-code solution. Some advantages of using Workflows instead of SQL is that we can have a single query doing everything without worrying of temporal tables (Workflows takes care of that) and provides a more natural way to link together the different steps: you will understand later once we start using some of [CARTO Analytics Toolbox](https://docs.carto.com/faqs/analytics-toolbox)’s functions that the nested queries become harder to grasp without previous experience using it.

## Presenting the Data

The data comes in three different source tables:

- **Violent crimes data**. The data we will be using contains information of reported incidents of crime that occurred in the City of Chicago from 2001 to present, minus the most recent seven days. Data is extracted from the Chicago Police Department's CLEAR (Citizen Law Enforcement Analysis and Reporting) system and in available in [Google BigQuery public marketplace](https://cloud.google.com/bigquery/public-data). In order to protect the privacy of crime victims, addresses are shown at the block level only and specific locations are not identified. The data can be found in the public table `bigquery-public-data.chicago_crime.crime`. 
- **Demographic and socio-economic data**. We will also be using American Community Survey (ACS) Data from CARTO spatial catalog, which are publicly available at the block group resolution using [5-years estimates](https://carto.com/spatial-data-catalog/browser/?provider=usa_acs&search=5yrs) from 2007 to 2018 and then [1-years estimates](https://carto.com/spatial-data-catalog/browser/?provider=usa_acs&search=yearly) for 2019 and 2020.
- **Holiday data**. This [BigQuery ML public dataset](https://cloud.google.com/blog/products/data-analytics/customized-holiday-modeling-with-bigquery-ml-forecasting) reports holiday data for a custom holiday region.
  
## Data pre-processing

For this use case, we are not interested in working with the individual reports. While we could use Census Block Groups, the units adopted by the ACS dataset, we will opt for a spatial index grid. This regular grid offers several advantages over the irregular polygons of Census Block Groups, particularly in terms of computation, storage, and visualization, as outlined in the next section.

### Spatial Indexes

Quoting CARTO's quickstart guide on Spatial Indexes:

> *Spatial Indexes are multi-resolution, hierarchical grids that are “geolocated” by a short reference string, rather than a complex geometry*

Spatial indexes are, therefore, some kind of IDs that always point to the same portion of land. We can also traverse a hierarchy of cells: having the ID of a cell, we can get the parent cell (a larger cell that contains the one we are working with) or the children cell (all the cells that are contained within it).

There are some obvious performance gains using spatial indexes:

- They are much **smaller to store**: they are represented with an integer or a string, so we save having a full geometry in the database.
- They are more **natural for cloud data warehouses**: being an integer or a string, most operations can be run using a `JOIN` or a `GROUP BY` natively.
- They function as a **common ground for all your data**: no need to worry about how to mix your points, lines and geometries; we can almost always project these data to a continuous, deterministic and performant grid structure.

There are two main spatial indexes to take into account, that should cover a vast majority of the use cases:

- **H3**, which provides a hexagonal grid. The main advantage it provides is that, **for each and every cell, all of its neighbor's centroids are at the same distance of its own**. This is by definition of what a regular hexagon is and does not happen in quadrilateral shapes: the North neighbor is closer than the North-East one.
- On the other hand we have **Quadbin**, which provides a quadrangular grid. The advantage it has compared to H3 is that **each of the square cells are exactly subdivided in four children cells**. This is not the case in H3: hexagons cannot be cleanly subdivided in hexagonal children cells; the relation is approximate.

Except very specific use cases, most times it comes down to personal preference or the fact that hexagons look cool on a map. Today, since later we are going to use neighbor rings (K-rings), let's choose H3. Let's start by [polyfilling](https://docs.carto.com/carto-user-manual/workflows/components/spatial-indexes) the area of interest by creating an H3 grid of resolution 7 (about 1.2 km of edge length) of the whole city of Chicago, whose boundary is store in the public table `cartobq.docs.CHI_boundary`.

### Enrichment Functions

Next, we will intersect and enrich each H3 cells with selected ACS variables from all the available survey years, by specifying the most appropiate aggregation function for each variable, e.g. the `SUM`for extensive variables (which will vary as the size of a feature changes, like the total population) and the `AVG`for intensive variables (like the median income). The `ENRICH_GRID` component does exactly what we need for this. 

For extensive variables, which usually require the `SUM` aggregation, it will return (per cell):
- In case there is a single block group intersecting the cell: the areal proportion of the block group (if the cell intersects one third of the block group, it will get one third of the population).
- In case there are multiple block groups intersecting the cells: the sum of the areal proportions of all the block groups. 

Similarly, if we were using the `AVG` aggregation instead, we would get the weighted average based on the intersecting area, and if we were using the `MIN`/`MAX` function the minimum/maximum of the intersecting geometries. If we were using lines, it would use the length instead of the area and, if we were using points, the `COUNT` aggregation is often useful.

There is, however, another thing to take into account: these enrichment functions have been developed (at least by now) with a geographical intent in mind. We cannot use them as-is to enrich a grid that is also indexed by time (we would lose our date column by calling the `ENRICH_GRID` component, since it will keep a single row per H3). For this reason, we enrich the datasets for each survey years separately and then union all the results.

[![01-enrichment](sdsc24-ny-workshop/img/01-enrichment.png)](https://clausa.app.carto.com/workflows/18ade665-ab32-4d2a-af74-5e586fd7c39d)

Now we have projected the data into the H3 grid, but for extensive variables it is important to understand that in this way we have either aggregated or disaggregated the original census variables, which might result in fractional population counts: for example, in case a blockgroup spans across 4 different H3 cells, for each person person living in that block group each will receive 0.25 people. This is a weird measurement, especially if we were to show this in a dashboard to end users, but it is perfectly fine for the analysis that we are going to perform.

### Dimensionality reduction

Before including the crime count data too, we want to reduce the dimensionality of the enriched data to reduce model complexity when we will use this data later on to model crime counts. 

To do do this we can borrow some procedure from CARTO AT, which implement the Factorial Analysis of Mixed Data (FAMD) method developed by [Pagés (2004)](http://www.numdam.org/article/RSA_2004__52_4_93_0.pdf). This method generalizes the use of [Principal Component Analysis (PCA)](https://en.wikipedia.org/wiki/Principal_component_analysis) to account for the number of modalities available to each categorical/ordinal variable and on the probabilities of these modalities. Depending on the variable type, he procedure applies the following transformations to the input data:

- For the numerical variables: standard scale the columns to get their z-scores
- For the categorical variables:
  - One-hot-encode the categorical columns to get their indicator matrix
  - Weight each column by the inverse of the square root of its probability, given by the number of ones in each column (Ns) divided by the number of observations (N)
  - Center the columns
  - For ordinal variables we can choose from different encoding methods and by apply the correspoding weight:
- Categorical encoding: ordinal variables are hot-encoded and the columns of the resulting indicator matrix are then weighted and centered as in the FAMD method
- Numerical encoding: ordinal variables are treated as numerical variables

This procedure is not available yet as a Workflows component, and therefore we have to include it in our workflow using a [`Call Procedure`](https://docs.carto.com/carto-user-manual/workflows/components/custom#call-procedure) component:

```sql
/*==================== native.call (v2.0.0) [10e7ba75-f9ac-411c-a500-96f7b328cda8]  ====================*/
BEGIN
DROP TABLE IF EXISTS `cartodb-on-gcp-datascience.workflows_temp.WORKFLOW_1eb31dcc6f1f182c_fe520e627008f0a3_result`;
BEGIN
  DROP TABLE IF EXISTS `cartobq.sdsc24_ny_workshops.CHI_boundary_pca_model_data`;
  
  CALL `carto-un`.carto.BUILD_PCAMIX_DATA(
    '''SELECT * FROM `cartodb-on-gcp-datascience.workflows_temp.WORKFLOW_1eb31dcc6f1f182c_0b481cc2d3651984_result`''',
  'uuid',
  ['median_age_avg',
  'median_rent_avg',
  'black_pop_sum',
  'hispanic_pop_sum',
  'owner_occupied_housing_units_median_value_sum',
  'vacant_housing_units_sum',
  'housing_units_sum',
  'families_with_young_children_sum'],
  NULL,
  ['urbanity_any_ordinal'],
  'cartobq.sdsc24_ny_workshops.CHI_boundary_pca',
  '''{
  "ordinal_encoding":"CATEGORICAL"
  }
  '''
  );
  DROP TABLE IF EXISTS `cartodb-on-gcp-datascience.workflows_temp.WORKFLOW_1eb31dcc6f1f182c_fe520e627008f0a3_result_dryrun`;
  
END;
END;

/*==================== native.call (v2.0.0) [770c3148-08c0-46da-bb63-e11446a12e41]  ====================*/
BEGIN
DROP TABLE IF EXISTS `cartodb-on-gcp-datascience.workflows_temp.WORKFLOW_1eb31dcc6f1f182c_23edec6fd3ac0d0b_result`;
BEGIN
  CALL `carto-un`.carto.BUILD_PCAMIX_MODEL(
  '''SELECT * FROM `cartobq.sdsc24_ny_workshops.CHI_boundary_pca_model_data`''',
  'uuid',
  'cartobq.sdsc24_ny_workshops.CHI_boundary_pca_model',
  '''{
  "NUM_PRINCIPAL_COMPONENTS":2}'''
  );
  
  CALL `carto-un`.carto.PREDICT_PCAMIX_SCORES(
  '''SELECT * FROM `cartobq.sdsc24_ny_workshops.CHI_boundary_pca_model_data`''',
  'uiid',
  'cartobq.sdsc24_ny_workshops.CHI_boundary_pca_model',
  'cartobq.sdsc24_ny_workshops.CHI_boundary_pca_scores'
  );
  DROP TABLE IF EXISTS `cartodb-on-gcp-datascience.workflows_temp.WORKFLOW_1eb31dcc6f1f182c_23edec6fd3ac0d0b_result_dryrun`;
  
END;
END;
```
From the code above, we can see that the urbanity variable, first transformed to an ordinal variable with the following schema

![02-case_when](sdsc24-ny-workshop/img/02-case_when.png)

is treated as a categorical variable when including it in the procedure that prepares the input data ([`BUILD_PCAMIX_DATA`](https://docs.carto.com/data-and-analysis/analytics-toolbox-for-bigquery/sql-reference/statistics#build_pcamix_data)) for the dimensionality reduction analysis, which is later executed by the [`BUILD_PCAMIX_MODEL`](https://docs.carto.com/data-and-analysis/analytics-toolbox-for-bigquery/sql-reference/statistics#build_pcamix_model), which runs the PCA model with the transformed data, and by [`PREDICT_PCAMIX_SCORES`](https://docs.carto.com/data-and-analysis/analytics-toolbox-for-bigquery/sql-reference/statistics#predict_pcamix_scores), which extracts the first two principal component scores (a.k.a. the transformed variables that account for most of the variance in the input data). 

[![03-famd](sdsc24-ny-workshop/img/03-famd.png)](https://clausa.app.carto.com/workflows/654b0fc8-bc68-450c-b0c8-a43c071b4af0)

### Adding the temporal dimension

We next turn to processing the crimes data, which comes as individual reported crimes with the crime type, report date and location as given by the centroid of the corresponding Census block. To simplify the analysis, we will assume that the given coordinates are the exact coordinates of the crime, and when these are not available we will try to infer them using the [`ST Geocode`](https://docs.carto.com/carto-user-manual/workflows/components/spatial-constructors#st-geocode) component, using the block name as the address.

The crime data are then aggregated by intersecting the coordinates of each individual report with the H3 grid and then computing the total counts per H3 cell and week (although we could work with daily data, for this use case it is probably going to be far too sparse, and that's why we decided to aggregate the series in weekly steps instead).

Finally, the time series for each H3 cell is gap-filled by adding zeros for weeks without any reported crime and joined with the enriched data from the previous section using the closest ACS survey year.

[![04-ts_processing](sdsc24-ny-workshop/img/04-ts_processing.png)](https://clausa.app.carto.com/workflows/7ebd5d2a-7963-41d4-8e6f-781035a05f48)

Here is a map where we can explore the final dataset:

[![05-input_data_map](sdsc24-ny-workshop/img/05-input_data_map.png)](https://clausa.app.carto.com/builder/fee8da00-46d3-426c-b97c-523e66732550)

## Exploratory Analysis: space-time insights

### Space-time Getis-Ord

As someone who works with spatial data, one of the most common types of questions you'll be asked will be about spatial trends or patterns. This is typically framed as the question "where is variable X highest and lowest?". While these questions can be explored cartographically - such as through choropleth maps which depict the value of a variable through color - it is often important to go beyond this with a quantitative measure of these spatial trends; hotspot analysis.

But what about space-time data? We need a statistics that allows you to add the extra dimension of time, by identifying not just where hotspots are, but where and when they are.

#### Space-time Getis-Ord

Getis-Ord is a family of statistics used to perform hotspot analysis: measure of value and how it correlates with its surroundings. The higher the value of the metric to measure in a cell, as well as the surrounding cells, the higher the metric. This way, we have a better insight on what are the dynamics from a geographical point of view: we are smoothing the noise out of the visualization.

Space-time Getis-Ord iterates on this same concept, but adding time as a new dimension: now, the surroundings of a cell are not only its neighbors, but also the adjacent time steps (those same neighbors $N$ time steps before). If we had a 2D kernel before, now it is 3D. We can compute the space-time Getis-Ord statistics $G_i^*$ and its associated p-value using the [`Getis Ord Spacetime`](https://docs.carto.com/carto-user-manual/workflows/components/statistics#getis-ord-spacetime) component.

By performing this statistic, we can now check how different parts of the city become _hotter_ or _colder_ as time progresses. This is already insightful, but we have two more functions still that will help us extract more knowledge of this result.

[![06-getis_ord_map](sdsc24-ny-workshop/img/06-getis_ord_map.png)](https://clausa.app.carto.com/builder/fee8da00-46d3-426c-b97c-523e66732550)

#### Emerging Hotspots

There is yet another analysis we can apply to the space-time Getis-Ord results, that will digest the results into a single map based on several predefined categories:

| Category                 | Description                                                                                                                                                                                                                           |
| :----------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `Undetected Pattern`     | This category applies to locations that do not exhibit any discernible patterns of hot or cold activity as defined in subsequent categories.                                                                                          |
| `Incipient Hotspot`      | This denotes a location that has become a significant hotspot only in the latest observed time step, without any prior history of significant hotspot activity.                                                                       |
| `Sequential Hotspot`     | Identifies a location experiencing an unbroken series of significant hotspot activity leading up to the most recent time step, provided it had no such activity beforehand and less than 90% of all observed intervals were hotspots. |
| `Strengthening Hotspot`  | A location consistently identified as a hotspot in at least 90% of time steps, including the last, where there's a statistically significant upward trend in activity intensity.                                                      |
| `Stable Hotspot`         | Represents a location maintaining significant hotspot status in at least 90% of time steps without showing a clear trend in activity intensity changes over time.                                                                     |
| `Declining Hotspot`      | A location that has consistently been a hotspot in at least 90% of time steps, including the most recent one, but shows a statistically significant decrease in the intensity of its activity.                                        |
| `Occasional Hotspot`     | Locations that sporadically become hotspot, with less than 90% of time steps marked as significant hotspots and no instances of being a significant coldspot.                                                                         |
| `Fluctuating Hotspot`    | Marks a location as a significant hotspot in the latest time step that has also experienced significant coldspot phases in the past, with less than 90% of intervals as significant hotspots.                                         |
| `Legacy Hotspot`         | A location that isn't currently a hotspot but was significantly so in at least 90% of past intervals.                                                                                                                                 |
| `Incipient Coldspot`     | Identifies a location that is marked as a significant coldspot for the first time in the latest observed interval, without any previous history of significant coldspot status.                                                       |
| `Sequential Coldspot`    | A location with a continuous stretch of significant coldspot activity leading up to the latest interval, provided it wasn't identified as a coldspot before this streak and less than 90% of intervals were marked as coldspots.      |
| `Strengthening Coldspot` | A location identified as a coldspot in at least 90% of observed intervals, including the most recent, where there's a statistically significant increase in the intensity of low activity.                                            |
| `Stable Coldspot`        | A location that has been a significant coldspot in at least 90% of intervals without any discernible trend in the intensity of low activity over time.                                                                                |
| `Declining Coldspot`     | Locations that have been significant coldspots in at least 90% of time steps, including the latest, but show a significant decrease in low activity intensity.                                                                        |
| `Occasional Coldspot`    | Represents locations that sporadically become significant coldspots, with less than 90% of time steps marked as significant coldspots and no instances of being a significant hot spot.                                               |
| `Fluctuating Coldspot`   | A location marked as a significant coldspot in the latest interval that has also been a significant hot spot in past intervals, with less than 90% of intervals marked as significant coldspots.                                      |
| `Legacy Coldspot`        | Locations that are not currently coldspots but were significantly so in at least 90% of past intervals.                                                                                                                               |

To run this classification, we can use the [`Spacetime Hotspots Classification`](https://docs.carto.com/carto-user-manual/workflows/components/statistics#spacetime-hotspots-classification) component, which takes the output of `Getis Ord Spacetime` and classifies each location into specific types of hotspots or coldspots, based on patterns of spatial clustering and intensity trends over time.

[![07-hotspots_map](sdsc24-ny-workshop/img/07-hotspots_map.png)](https://clausa.app.carto.com/builder/9648406f-7790-4784-8b53-2e618fd2f494)

We can see how now we have the different types of behaviors at a glance in a single map. There are several insights we can extract from this map:

- There is an large stable hotspot near West Garfield Park, one of [Chicago's most violent neighborhoods](https://graphics.suntimes.com/2023/chicago-most-violent-neighborhood-garfield-park-residents-stories/), that shows an upward trend in violent crimes.
- The periphery of the city is mostly cold spots, with some stable coldspots in the north east suburban villages and many fluctuating coldspots in the South Suburbs.
- Englewood which historically has struggled with high levels of violent crime, is classified as a declining hotspot, which might reflect the effects of  the initial phase of the recent Chicago’s [INVEST South/West commercial corridor improvement strategy](https://www.chicago.gov/city/en/sites/invest_sw/home/greater-englewood.html)

Here is the complete workflow:

[![08-hotspots](sdsc24-ny-workshop/img/08-hotspots.png)](https://clausa.app.carto.com/workflows/3e9e125c-d010-4c29-ae68-e4916e00c480)

### Time Series Clustering

Once we have an initial understanding of the spacetime patterns of our data, we can also try to cluster H3 cells based on their temporal patterns using the [`Cluster Time Series`](https://docs.carto.com/carto-user-manual/workflows/components/statistics#cluster-time-series) component. This component allows to generate $N$ clusters of time series, using different clustering methods. Right now, it features two very simple approaches:

- Value characteristic, that will cluster the series based on the step-by-step distance of its values (the closer the signals, the closer the series). This method applies a [K-means clustering](https://en.wikipedia.org/wiki/K-means_clustering) using the [Euclidean distance](https://en.wikipedia.org/wiki/Euclidean_distance);
- Profile characteristic, that will cluster the series based on their dynamics along the time span passed (the closer the correlation, the closer the series). This method applies a [K-means clustering](https://en.wikipedia.org/wiki/K-means_clustering) using the [Cosine distance](https://en.wikipedia.org/wiki/Cosine_similarity).

[![09-ts_clustering](sdsc24-ny-workshop/img/09-ts_clustering.png)](https://clausa.app.carto.com/workflows/0035f38f-aa97-4561-b401-64375c77774c)

In this map shows the different clusters that are returned as a result:

[![10-ts_clustering_map](sdsc24-ny-workshop/img/10-ts_clustering_map.png)](https://clausa.app.carto.com/builder/0cc5cb88-7869-48b6-bb9a-d9f5c928ed67)

We can identify the different dynamics using the widget to select the clustering method:

- When clustering using the `PROFILE` method, we can identify group of time series with different seasonalities and trends (e.g. group `#4` is characterized by a large seasonal cycle while group `#3` does not show any seasonal variability; groups `#2` and `#4` seem to be characterized both by a downward trend until 2013 but only group `#2` shows a (slight) upward trend form 2013 onwards).
- Using the `VALUE` method, we can clearly identify areas with very different crime levels, from group `#4` with very high-levels to group `#1` with very low values. 

## Inferential analysis

Building on the insights gained from the exploratory analysis, the next step involves performing inferential analysis to draw conclusions and make predictions about the broader population based on the available data.

### Getting the estimated counts

First, we aim to estimate the expected counts, conditional on selected covariates. In addition to the first two principal component scores derived from external data (ACS and CARTO Spatial Features), we can also add endogenous variables. These include spatial lag variables to account for the influence of neighboring regions (since outcomes in one area may affect outcomes in nearby areas due to spatial interactions or spillover effects), counts at previous time lags to model the impact of past values on current or future outcomes (capturing autocorrelation), and seasonal terms to account for repeating seasonal behaviors, which can be represented as Fourier terms by summing sine and cosine functions of different frequencies.

[![11-ts_model_data_prep](sdsc24-ny-workshop/img/11-ts_model_data_prep.png)](https://clausa.app.carto.com/workflows/db5a0a0b-92f2-4f0a-91cd-4b292c9657b7)

Next, we can import a [pre-trained](https://cloud.google.com/bigquery/docs/reference/standard-sql/bigqueryml-syntax-create-onnx) statistical model into BigQuery to estimate the crime counts for the latest version of the data. While we could train a similar model using [BigQuery ML](https://cloud.google.com/bigquery/docs/reference/standard-sql/bigqueryml-syntax-create), importing a pre-trained model allows for an implementation within a Python/PyTorch/TensorFlow environment, which many Data Scientists prefer. The pre-trained model is a linear regression model, designed to estimate the ratio of crime counts per 1000 people based on the selected covariates and is saved in [ONNX format](https://onnx.ai/) in Google Cloud Storage (GCS) in [this public bucket](https://storage.googleapis.com/sdsc_workshops/sdsc24_10/arima_plus_model_opset8_onehot.onnx). A notebook, with the code to train the model and save it to GCS is available [here](). To import the model in BiQuery and make predictions with BigQuery [ML.PREDICT](https://cloud.google.com/bigquery/docs/reference/standard-sql/bigqueryml-syntax-predict) statement we need to call again the [`Call Procedure`](https://docs.carto.com/carto-user-manual/workflows/components/custom#call-procedure) component, since these are not available yet as a Workflows component yet: 

[![12-ts_model](sdsc24-ny-workshop/img/12-ts_model.png)](https://clausa.app.carto.com/workflows/7bcaf437-50d9-4357-8d6f-f003376d4901)

```sql
/*==================== native.call (v2.0.0) [90cefe53-db69-456b-9c73-432e7ef7fb0f]  ====================*/
BEGIN
DROP TABLE IF EXISTS `cartodb-on-gcp-datascience.workflows_temp.WORKFLOW_62d8b5586bc34a3c_b398bcedfda87277_result`;
BEGIN
  CREATE OR REPLACE MODEL `cartobq.sdsc24_ny_workshops.CHI_boundary_SKLEARN_ONNX_model_opset8`
  OPTIONS (MODEL_TYPE='ONNX',  MODEL_PATH='gs://sdsc_workshops/sdsc24_10/arima_plus_model_opset8_onehot.onnx');
  DROP TABLE IF EXISTS `cartodb-on-gcp-datascience.workflows_temp.WORKFLOW_62d8b5586bc34a3c_b398bcedfda87277_result_dryrun`;
  
END;
END;

/*==================== native.customsql (v2.0.0) [ee3041d5-29f6-4519-959b-08edaaccc749]  ====================*/
BEGIN
DROP TABLE IF EXISTS `cartodb-on-gcp-datascience.workflows_temp.WORKFLOW_62d8b5586bc34a3c_ad0276c13da6145d_result`;
CREATE TABLE `cartodb-on-gcp-datascience.workflows_temp.WORKFLOW_62d8b5586bc34a3c_ad0276c13da6145d_result`
OPTIONS (
  expiration_timestamp = TIMESTAMP_ADD(
    CURRENT_TIMESTAMP(), INTERVAL 30 DAY
  )
)
AS
  SELECT *
  FROM ML.PREDICT(
  MODEL `cartobq.sdsc24_ny_workshops.CHI_boundary_arima_plus_xreg_model`, 
  (SELECT * FROM `cartodb-on-gcp-datascience.workflows_temp.WORKFLOW_62d8b5586bc34a3c_d579f92b5a05a4a5_result`)
  )
  
  ORDER BY h3, week;
END;
```
This map shows the observed and estimated counts for the ten H3 cells with the highest number of crimes over all the period:

[![13-ts_model_map](sdsc24-ny-workshop/img/13-ts_model_map.png)](https://clausa.app.carto.com/builder/d8b81fe2-0fad-49eb-a879-fa56c8941a6b)


### Detect space-time anomalies

## Closing Thoughts
