# Code for the paper: _A Bayesian spatial analysis of the association of socioeconomic inequality and epidemiological conditions and human mobility changes during the US COVID-19 epidemic_ by Carella et al., sumitted to The Lancet Infectious Diseases

Giulia Carella (giulia.carella@bsc.es)

This repository contains the code to reproduce the results from the manuscript. To run the scripts to retrieve the data, a [CARTO account](https://carto.com/) and a subscription to [Applied Geographic Solutions' sociodemographics and buisness counts data](https://carto.com/spatial-data-catalog/browser/?category=demographics&provider=ags) are required.

## Repository structure

1. **/etl**

	- `etl_0_join_mobility_cases_data.ipynb`: code to retrieve county-level Google workplaces mobility data and COVID-19 epidemiological data.

	- `etl_1_join_census_data.ipynb`: code to retrieve Applied Geographic Solutions' sociodemographics and buisness counts data at the Census block group level and aggregate the data at the county level. 

	- `etl_2_preprocess.ipynb`: code to pre-process Google's workplaces mobility data as described in the manuscript. 

2. **/models**
	 
	- `models_0_beta_and_betaspatial_models.ipynb`: code to run the Beta-model and the Beta-spatial model described in the manuscript.

	- `model_1_plot_spatial_effects.ipynb.ipynb`: code to plot the random spatial effects of the Beta-spatial model.

3. **/data**

	- `FIPS_states.csv`:  FIPS codes and associated state names.

4. **/src**: utility scripts
