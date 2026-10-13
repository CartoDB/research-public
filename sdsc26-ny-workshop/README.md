# SDSC26 New York - From Geo-Embeddings to Spatial Applications: Working with PlacePulse in CARTO

**Spatial Data Science Conference 2026, New York, 20 October 2026**

*Lucía García-Duarte (lgarciaduarte@carto.com), CARTO &
Gary Menger (gary@appliedgeographic.com), Applied Geographic Solutions (AGS)*

--------

This repository contains the material for the workshop *"From Geo-Embeddings to Spatial Applications: Working with PlacePulse in CARTO"*. It includes:

- The [slides](/sdsc26-ny-workshop/materials/deck.pdf) used during the workshop, in PDF format
- The [report](/sdsc26-ny-workshop/materials/report.html) with the maps, charts and conclusions of the analysis
- The [SQL files](/sdsc26-ny-workshop/workflows) for the three workflows used in the workshop

## The use case

[Erewhon](https://erewhon.com/about) is an upscale organic grocery chain and lifestyle brand based in Los Angeles. Its 13 stores draw visitors from across the region. The workshop combines visitor data from [Advan](https://advanresearch.com/) with [PlacePulse embeddings](https://carto.com/blog/placepulse-embeddings-fingerprint-every-place-us/) to answer three business questions:

1. **What kind of places do Erewhon visitors come from?** We want to learn which types of neighbourhood send visitors to the stores, and how these neighbourhoods differ from the rest of Los Angeles.
2. **Where should Erewhon target its next marketing campaign?** We want to find the places that look like the Erewhon customer base but send few visits to the stores today.
3. **How many visits would a new store get?** We want to estimate the visits and the 60% trade area of two candidate locations (Costa Mesa and Thousand Oaks) before Erewhon opens a store there.

During the session, we will learn how to answer the three business questions with [CARTO Workflows](https://docs.carto.com/carto-user-manual/workflows), the no-code analysis tool of CARTO. Then we will use Claude with the [CARTO MCP server](https://docs.carto.com/carto-for-agents/mcp-server) to explore the results in natural language and to create the maps, the charts and a final [report](/sdsc26-ny-workshop/materials/report.html) that is ready to share.

## Before the workshop

> [!IMPORTANT]
> Please complete steps 1 to 3 before the session. We will explain these steps briefly during the session, but the hands-on part goes much faster if they are already done.

### 1. Create a CARTO account

You need a CARTO account for this session. If you do not have one, sign up for a free 14-day trial at [app.carto.com/signup](https://app.carto.com/signup). The setup takes a couple of minutes.

> [!WARNING]
> There is a maximum of one CARTO account per email address. If you have set up a free trial with your email before, use an alternative email address for this session. If you have problems when you set up the account, contact support@carto.com.

### 2. Create a CARTO MCP server

During the session we use Claude with the CARTO MCP server to build workflows and maps from natural-language prompts. Follow the [CARTO MCP server documentation](https://docs.carto.com/carto-for-agents/mcp-server) to create an MCP server in your organization and connect it to your AI client (for example, Claude).

### 3. Install the Analytics on Embeddings extension package

The embedding components (Visualization, Clustering, Similarity Search, Mean Deviation, Neighbourhood Deviation and others) come in the [Analytics on Embeddings](https://docs.carto.com/carto-user-manual/workflows/components/embedding-analytics) extension package for Workflows. Follow the [extension packages guide](https://docs.carto.com/carto-user-manual/workflows/extension-packages) to install it in your organization. The workflows in this repository do not run without it.

### 4. Get familiar with PlacePulse

PlacePulse is a geospatial foundation model built by CARTO on the [AGS](https://appliedgeographic.com/) data product. For each H3 cell at resolution 7 in the US, it compresses 2,288 attributes (sociodemographics, business mix, income, mobility, health, climate risk) into a single 256-dimension vector. Similar places get similar vectors, so you can use the vectors for similarity search, clustering, anomaly detection, prediction and more. 

These resources explain what PlacePulse is and how to use it in CARTO Workflows:

- [PlacePulse embeddings: a fingerprint for every place in the US](https://carto.com/blog/placepulse-embeddings-fingerprint-every-place-us/)
- [PlacePulse in the CARTO Spatial Data Catalog](https://carto.com/spatial-data-catalog/browser/?dataset=cdb_placepulse_28abb883)
- [Turning geospatial foundation models into decisions using CARTO Workflows](https://carto.com/blog/turning-geospatial-foundation-models-into-decisions-using-carto-workflows/)
- [From embeddings to spatial insights: Five new tools in CARTO Workflows](https://carto.com/blog/from-embeddings-to-spatial-insights/)


## Input data

All the input tables are in the public, read-only Google BigQuery dataset `cartobq.docs`. Every user can read these tables from the BigQuery console or from a CARTO connection, so you do not need to upload any data. If you do not have a BigQuery connection in CARTO, use the [CARTO Data Warehouse](https://docs.carto.com/carto-user-manual/connections/carto-data-warehouse) connection. Every CARTO trial account includes this connection.

| Table | Description |
|---|---|
| `cartobq.docs.placepulse_embeddings_la` | PlacePulse embeddings for the area of interest |
| `cartobq.docs.erewhon_la_stores` | The 13 Erewhon stores in Los Angeles (points) |
| `cartobq.docs.erewhon_visits_by_h3z7_la` | Visits from each origin H3 cell (resolution 7) to each store, from Advan |
| `cartobq.docs.erewhon_new_stores` | The two candidate store locations (Costa Mesa and Thousand Oaks) |


## The `materials` folder

The [`materials`](/sdsc26-ny-workshop/materials) folder contains:

- [`deck.pdf`](/sdsc26-ny-workshop/materials/deck.pdf): the slides of the session. They cover geospatial foundation models, how PlacePulse is built, the AGS data that trains it, the use case and the prompts that we use with the CARTO MCP server.
- [`report.html`](/sdsc26-ny-workshop/materials/report.html): the final report of the analysis, generated with Claude and the CARTO MCP server. It contains four embedded CARTO maps, the charts and the conclusions for each business question. Download the file and open it in your browser.

## The `workflows` folder

The [`workflows`](/sdsc26-ny-workshop/workflows) folder contains the three workflows of the session as SQL files:

| File | Description |
|---|---|
| `01_profile_erewhon_customer_origins_with_placepulse_embeddings.sql` | Maps the PlacePulse embeddings of Los Angeles, scores how unusual each H3 cell is, and clusters the cells that send visitors to Erewhon stores |
| `02_target_the_marketing_campaign.sql` | Builds a PlacePulse profile for each Erewhon store and scores each H3 cell in Los Angeles by its similarity to the stores and its current visits |
| `03_estimate_visitor_counts.sql` | Trains a random forest model on the 13 Erewhon stores and predicts the visits and the 60% trade area of two new stores |

> [!NOTE]
> To reproduce a workflow, download its SQL file and [import it into your organization](https://docs.carto.com/carto-user-manual/workflows/sharing-workflows#import-a-workflow-from-a-sql-file).
> - The [`Save as Table`](https://docs.carto.com/carto-user-manual/workflows/components/input-output#save-as-table) components are empty. Before you run the workflow, set a destination that you can write to, or remove the component. For example, if you use the `shared` dataset of your [CARTO Data Warehouse](https://docs.carto.com/carto-user-manual/connections/carto-data-warehouse) and its BigQuery project is `carto-dw-ac-123`, set the destination to `carto-dw-ac-123.shared.<table_name>`.
> - The `Create Regression Model` component in `03_estimate_visitor_counts.sql` is empty. Before you run the workflow, set the model name to a location that you can write to. For example, set it to `carto-dw-ac-123.shared.erewhon_visitors_model_rf`.
> - The embedding components need the Analytics on Embeddings extension package from step 3 of [Before the workshop](#before-the-workshop).
