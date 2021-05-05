# Code for the paper: _A Bayesian spatial analysis of the association of socioeconomic inequality and perceived risk of infection with human mobility changes during the first wave of the US COVID-19 epidemic_ by Carella et al., 2020 submitted to The American Statistician

Giulia Carella (giulia.carella@bsc.es)

This repository contains the code to reproduce the results from the manuscript. To run the scripts to retrieve the data, a [CARTO account](https://carto.com/) and a subscription to [Applied Geographic Solutions' sociodemographics and buisness counts data](https://carto.com/spatial-data-catalog/browser/?category=demographics&provider=ags) are required.

## Repository structure

```
├── etl                                             # ETL
    ├── etl_0_join_mobility_cases_data.ipynb        # code to retrieve county-level Google workplaces mobility data and COVID-19 epidemiological data
    ├── etl_1_join_census_data.ipynb                # code to retrieve Applied Geographic Solutions' sociodemographics and buisness counts data at the Census block group level and aggregate the data at the county level
    ├── etl_2_preprocess.ipynb                      # code to pre-process Google's workplaces mobility data
    ├── etl_3_pca_census_data.ipynb                 # code to extract PC scores from Census data    
├── models                                          # Models
    ├── models_0_beta_and_betaspatial_models.ipynb  # code to run the models
    ├── model_1_plot_spatial_effects.ipynb          # code to plot the sum of the IID and spatial random effects for the Beta-spatial model
├── src                                             # Source files, tools and utilities
    ├── requirements.txt                            # install required python packages
    ├── requirements.py                             # import required python packages
    ├── utils.py                                    # python utils functions
    ├── requirements.R                              # install and load required R packages
    ├── utils.R                                     # R utils functions
├── data                                            # Data
    ├── FIPS_states.csv                             # FIPS codes and associated state names
├── plots                                           # Plots
└── README.md
```
