# Code for the paper `A Bayesian spatial analysis of the association of socioeconomic inequality and epidemiological conditions and human mobility changes during the US COVID19 epidemic` by Carella et al. sumitted to The Lancet Infectious Diseases

Giulia Carella (giulia.carella@bsc.es)

This repository contains the code to reproduce the results from the manuscript. To run the scripts to retrieve the data a CARTO account (https://carto.com/) and a subscription to Applied Geographic Solutions' sociodemographics and buisness counts data are required.

## Repository structure

1. **/etl**

Contains two scripts to retrieve the data used in the study

- `etl_0_join_mobility_cases_data.ipynb` ([static preview]()): code to retrieve, at the county level, Google workplaces mobility data and join them with the epidemiological data

- `etl_1_join_census_data.ipynb` ([static preview]()): code to retrieve Applied Geographic Solutions' sociodemographics and buisness counts data at the Census block group level, aggregate them at the county level and join them with the dataset created in `etl_0_join_mobility_cases_data.ipynb`. 

- `etl_2_preprocess.ipynb` ([static preview]()): code to pre-process Google's mobility data as described in the manuscript. 

2. **/models**
	 
- `models_0_beta_and_betaspatial_models.ipynb` ([static preview]()): code to run the Beta-model and the Beta-spatial model described in the manuscript

- `model_1_plot_spatial_effects.ipynb.ipynb` ([static preview]()): code to plot the random spatial effects of the Beta-spatial model 

3. **/data**

- `FIPS_states.csv`: contains the FIPS codes and the associated state name.

4 **/src**: utility code
