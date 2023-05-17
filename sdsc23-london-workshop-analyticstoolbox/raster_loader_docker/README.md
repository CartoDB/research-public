# Upload a raster to Google Bigquery with CARTO raster loader via Docker

- Download [Docker](https://www.docker.com/)
- Download the example raster data from [here](https://catalogue.ceh.ac.uk/documents/d6f8c045-521b-476e-b0d6-b3b97715c138) and store them in the data folder with the name _gb2020lcm1km_dominant_aggregate.tif_
- Open the command line and run  `docker-compose build` to build the docker image
- Authenticate with the [gcloud CLI](https://cloud.google.com/sdk/gcloud/reference/auth/login) by running `gcloud auth login` to authorize gcloud to access the Cloud Platform with Google user credentials
- Run `docker-compose run loader` to run the script