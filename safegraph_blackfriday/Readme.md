# Understanding US Black Friday Shopping Trends with Spatial Analytics

Code for a blogpost and webinar done in collaboration with SafeGraph.
* blogpost: https://www.safegraph.com/blog/2021-black-friday
* webinar: https://www.safegraph.com/events/predicting-consumer-demand-analyzing-holiday-spending-in-2021


**Notebooks**:
- [safegraph_webinar.ipynb](/safegraph_blackfriday/safegraph_webinar.ipynb) : used to present insights in the seminar
- [safegraph_eda.ipynb](/safegraph_blackfriday/safegraph_eda.ipynb) : exploratory analysis and selection of top_categories
- [safegraph_load_jobs.ipynb](/safegraph_blackfriday/safegraph_load_jobs.ipynb) : refactor safegraph patterns in BQ to add h3 indices and bounding boxes
- [ts_hotspots.ipynb](/safegraph_blackfriday/ts_hotspots.ipynb) : generate time series graphs per category in hotspot areas for each city
- [ts_walmart.ipynb](/safegraph_blackfriday/ts_walmart.ipynb) : explores home blockgroups of walmart visitors and the evolution of average distance from home during black friday across years.


*Disclaimer: To reproduce these results you need a subscription to [SafeGraph patterns data](https://carto.com/spatial-data-catalog/browser/dataset/sg_patterns_a66a8e6d/)* 
