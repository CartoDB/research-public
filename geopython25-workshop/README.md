# GeoPython 2025 - Unlocking Smarter Property Risk Assessments with Spatio-Temporal Crime Insights and CARTO

February 24th 2025

Lucía García-Duarte (lgarciaduarte@carto.com)

The content of this session is derived from [this presentation](https://github.com/CartoDB/research-public/tree/master/sdsc24-ny-workshop) delivered at the NY [Spatial Data Science Conference](https://spatial-data-science-conference.com/) in 2024.

This repository contains the material for the workshop *Unlocking Smarter Property Risk Assessments with Spatio-Temporal Crime Insights and CARTO*. It includes:

- A [deck with the slides](/geopython25-workshop/materials/deck.pdf) used during the workshop
- A [complete transcript](/geopython25-workshop/materials/README.md) with supporting material like code, maps or images
- The [SQL scripts](/geopython25-workshop/sql) for all the workflows used in the workshop

## CARTO account

> [!IMPORTANT]
> For this session, you’ll need a CARTO account! If you don’t have one, you can set up a free 14-day trial at [app.carto.com](app.carto.com). This should only take a couple of minutes to do, but we do recommend setting this up before coming to the workshops so you can dive right in! All the SQL queries are expected to be run in Google BigQuery console or CARTO Data Warehouse console/Workflows. If you are running a trial, you can find the steps to access your console in the [CARTO Data Warehouse documentation](https://docs.carto.com/carto-user-manual/connections/carto-data-warehouse).

> [!WARNING]
> There is a maximum of one CARTO account per email address. If you have previously set up a free trial with your email, we recommend using an alternative email address for this session. If you run into any issues setting up an account, please contact support@carto.com.

> [!NOTE]
> To reproduce any of the workflows, go to the [`sql`](/geopython25-workshop/sql) folder, download the corresponding SQL script and [import it into your organization](https://docs.carto.com/carto-user-manual/workflows/sharing-workflows#import-a-workflow-from-a-sql-file).
> - For the workflow that uses a [`Call Procedure`](https://docs.carto.com/carto-user-manual/workflows/components/custom#call-procedure) component ([this](/geopython25-workshop/sql/(2:)%20GeoPython25%20-%20Unlocking%20Smarter%20Property%20Risk%20Assessments%20with%20Spatio-Temporal%20Crime%20Insights%20and%20CARTO.sql)), you will need to replace the dummy `<my-project>.<my-dataset>` with your project and dataset name (e.g. if you are using your `shared` dataset in your [`CARTO Data Warehouse`](https://docs.carto.com/carto-user-manual/connections/carto-data-warehouse) and its BigQuery project is `carto-dw-ac-wm7jx2tm`, you would need to replace it with `carto-dw-ac-wm7jx2tm.shared`).
> - For the workflow that imports subscribed data from the Data Obsrvatory ([this](/geopython25-workshop/sql/(1:)%20GeoPython25%20-%20Unlocking%20Smarter%20Property%20Risk%20Assessments%20with%20Spatio-Temporal%20Crime%20Insights%20and%20CARTO.sql)), you will need to first subscribe to the different sources following [this](https://docs.carto.com/carto-user-manual/data-observatory/subscribing-to-public-and-premium-datasets) tutorial, to later drag and drop the data into the canvas and replace the actual sources (you will get an error otherwise).

## Notes on the code and workflows

All the code uses the Google BigQuery project `cartobq.sdsc24_ny_workshops` to store the output tables. Since this is a public project, every table mentioned in the code is accesible for any user using the BigQuery console. On the other hand, it is read-only, so every time the code attempts to write a table in it, it will fail. Please edit the code with a project and dataset that you are allowed to write to. All of those tables do exist, so you can explore the output of each query without the need of actually running it.

