#!/bin/bash

# When using the commands in this script, make sure you have the following
# dependencies installed:
#   1. GDAL: https://gdal.org/
#   2. Google Cloud CLI: https://cloud.google.com/sdk/gcloud
#   3. CARTO's raster-loader: https://github.com/CartoDB/raster-loader

INPUT_FILE_NAME="path/to/your/file.tif"
PROCESSED_FILE_NAME="tmp/processed_file.tif"
GCP_PROJECT="your-gcp-project"
GCP_DATASET="your-gcp-dataset"
GCP_TABLE="your-gcp-table"

# This first step will simply take the input file (in this case, we downloaded
# it from OpenTopography) and convert it to an adequate file format for the
# raster-loader.
gdalwarp \
    $INPUT_FILE_NAME \
    -of COG \
    -co TILING_SCHEME=GoogleMapsCompatible \
    -co COMPRESS=DEFLATE \
    $PROCESSED_FILE_NAME

# This next step will process the file and upload it into BigQuery using a
# format that the Analytics Toolbox raster module can read. Make sure to have a
# valid gcloud session with `gcloud auth application-default login`
carto bigquery upload \
    --file_path $PROCESSED_FILE_NAME \
    --project $GCP_PROJECT \
    --dataset $GCP_DATASET \
    --table $GCP_TABLE \
    --output_quadbin \
    --overwrite
