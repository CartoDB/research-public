# SDSC24 New York - Unlocking Smarter Property Risk Assessments with Spatio-Temporal Crime Insights and CARTO

October 16th 2024

Giulia Carella (giulia@carto.com)

This repository contains the material for the workshop *Unlocking Smarter Property Risk Assessments with Spatio-Temporal Crime Insights and CARTO*. It includes:

- A [deck with the slides](https://docs.google.com/presentation/d/1NH8p9kP1c1hgGg3OfSsYHo4RSsxpHlHz6ZVvJU20FrI/edit#slide=id.g306c8fd83b6_0_1517) used during the workshop
- A [complete transcript](https://github.com/CartoDB/research-public/blob/master/sdsc24-ny-workshop/transcript.md) with supporting material like code, maps or images;

## CARTO account

:page_facing_up: For this session, you’ll need a CARTO account! If you don’t have one, you can set up a free 14-day trial at [app.carto.com](app.carto.com). This should only take a couple of minutes to do, but we do recommend setting this up before coming to the workshops so you can dive right in! All the SQL queries are expected to be run in Google BigQuery console or CARTO Data Warehouse console/Workflows. If you are running a trial, you can find the steps to access your console in the [CARTO Data Warehouse documentation](https://docs.carto.com/carto-user-manual/connections/carto-data-warehouse).

:exclamation: There is a maximum of one CARTO account per email address. If you have previously set up a free trial with your email, we recommend using an alternative email address for this session. If you run into any issues setting up an account, please contact support@carto.com.

## Notes on the code and workflows

All the code uses the Google BigQuery project `cartobq.sdsc24_ny_workshops` to store the output tables. Since this is a public project, every table mentioned in the code is accesible for any user using the BigQuery console. On the other hand, it is read-only, so every time the code attempts to write a table in it, will fail. Please edit the code with a project and dataset that you are allowed to write to. All of those tables do exist, so you can explore the output of each query without the need of actually running it.

