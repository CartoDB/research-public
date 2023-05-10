#!/bin/bash

# Filenames used for input and output
INPUT_FILE="gb2020lcm1km_dominant_aggregate.tif"
OUTPUT_FILE="${INPUT_FILE/.tif/_quadbin.tif}"

INPUT_PATH="./data/$INPUT_FILE"
OUTPUT_PATH="./data/$OUTPUT_FILE"

mkdir -p  "./data"

# Google BigQuery variables
BQ_DATASET="your-dw-project"
GCP_DATASET="shared"
BQ_TABLE="composite_score_uk_landcover_raster"

gdalwarp "$INPUT_PATH" \
   -of COG \
   -co TILING_SCHEME=GoogleMapsCompatible \
   -co COMPRESS=DEFLATE \
   -co RESAMPLING=MODE \
   "$OUTPUT_PATH"

carto bigquery upload \
    --file_path "$OUTPUT_PATH" \
    --project "$BQ_DATASET" \
    --dataset "$GCP_DATASET" \
    --table "$BQ_TABLE" \
    --output_quadbin

rm "$INPUT_PATH"
rm "$OUTPUT_PATH"