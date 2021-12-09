import pandas as pd
import numpy as np
import geopandas as gpd

from shapely.geometry import box, Polygon
import h3
from collections import defaultdict

bboxes = {
    "chicago" : (-87.9574,41.661,-87.5412,42.04),
    "los_angeles" : (-118.507,33.66,-117.78, 34.148),
    "buffalo" : (-78.985778,42.723637,-78.67013,43.008951),
    "raleigh" : (-78.722225,35.715583,-78.558165,35.849233),
}

title_cities = {'chicago' : 'Chicago', 'los_angeles' : 'Los Angeles', 'buffalo' : "Buffalo", 'raleigh' : "Raleigh"}


cols = ('placekey',
 'latitude',
 'longitude',
 'date_range_start',
 'date_range_end',
 'raw_visit_counts',
 'raw_visitor_counts',
 'visits_by_day',
 'visitor_home_cbgs',
 #'popularity_by_hour',
 #'popularity_by_day',
 'top_category',
 'sub_category',
 'h3_z7',
 'h3_z8',
 'h3_z9')

chosen_categories = [
 'Grocery Stores',
 'Clothing Stores',
 'Sporting Goods, Hobby, and Musical Instrument Stores',
 'General Merchandise Stores, including Warehouse Clubs and Supercenters',
 'Department Stores',
 'Electronics and Appliance Stores']

bf_2019 = np.datetime64("2019-11-29")
bf_2020 = np.datetime64("2020-11-27")
bf_2021 = np.datetime64("2021-11-26")

get_h3_pol = lambda x : Polygon(h3.h3_to_geo_boundary(x, geo_json=True))

from doutils.bq import get_bq_client
bq_client = get_bq_client()

def explode_daily_counts(df):
    daily_visit_counts = df[["date_range_start", "date_range_end", "top_category", "visits_by_day"]]
    daily_visit_counts.loc[:,"date_range_start"] = daily_visit_counts["date_range_start"].apply(lambda x : x.tz_convert(None).floor("D"))
    daily_visit_counts.loc[:,"date_range_end"] = daily_visit_counts["date_range_end"].apply(lambda x : x.tz_convert(None).floor("D"))
    series = defaultdict(list)
    for i, g in daily_visit_counts.groupby(["date_range_start","date_range_end","top_category"]):
        start, end, cat = i
        visits = np.stack(g.visits_by_day.apply(lambda x: np.array(eval(x))).values)
        daily_visits = visits.sum(axis = 0)
        index = pd.date_range(start, end, freq = "D")[:-1]
        daily_df = pd.DataFrame(daily_visits, columns=[cat], index = index)
        series[cat].append(daily_df)
    daily_dfs = []
    for cat, elements in series.items():
        daily_dfs.append(pd.concat(elements).sort_index())
    ts_daily = pd.concat(daily_dfs, axis = 1)
    return ts_daily



def get_gettis_ord_df(city, h3_col):
    gettis_ord_q = f"""
    WITH visits_per_h3 as (
    SELECT {h3_col}, CAST(SUM(raw_visit_counts) AS FLOAT64) as sum_visits, AVG(raw_visit_counts) as avg_visits
     FROM `cartodb-on-gcp-datascience.juanluis.safegraph_blackfriday_{city}` 
     WHERE raw_visit_counts > 20 
     -- AND top_category IN tuple(chosen_categories)
     -- AND date_range_start >=  TIMESTAMP('2019-11-01') AND date_range_start <=  TIMESTAMP('2019-12-01')
     GROUP BY {h3_col}
    )
    SELECT 
    `carto-un`.statistics.GETIS_ORD_H3(ARRAY_AGG(STRUCT({h3_col}, sum_visits)),
     5,
    'gaussian') as gettis_ord_sum,
    FROM visits_per_h3;"""
    gettis_ord_out = bq_client.query(gettis_ord_q).result().to_dataframe()
    gettis_ord_df = pd.DataFrame(data = list(gettis_ord_out.iloc[0][0]))
    gettis_ord_df["geometry"] = list(map(get_h3_pol,gettis_ord_df["index"]))
    return gettis_ord_df


def find_hotspot_geometries(gettis_ord_df, top_quantile = 0.9, levels_up = 2, min_base_cells_in_grandparent = None, verbose = True):
    get_h3_n_levels_up = lambda x, n: h3.h3_to_parent(x, h3.h3_get_resolution(x) - n)
    gettis_ord_df["grandparent"] = gettis_ord_df["index"].apply(get_h3_n_levels_up, n = 2) # get hexagons two levels up
    
    top_q = gettis_ord_df.quantile(top_quantile).values[0]
    hotspots_base_cells = gettis_ord_df[gettis_ord_df.gi > top_q]
    
    hotspot_grandparent_cells = hotspots_base_cells.groupby("grandparent").gi.count().sort_values(ascending = False)
    if not min_base_cells_in_grandparent:
        min_base_cells_in_grandparent = hotspot_grandparent_cells.median()
    if verbose:
        print(hotspot_grandparent_cells.head(8))
        print("min_base_cells", min_base_cells_in_grandparent)
        
    hotspot_grandparent_cells = hotspot_grandparent_cells[hotspot_grandparent_cells >= min_base_cells_in_grandparent]
    hotspots_geom = list(map(get_h3_pol,hotspot_grandparent_cells.index))
    hotspots_gdf = gpd.GeoDataFrame(data = hotspot_grandparent_cells.index, geometry = hotspots_geom)
    return hotspots_gdf