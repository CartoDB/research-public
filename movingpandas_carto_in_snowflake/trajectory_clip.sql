CREATE OR REPLACE FUNCTION CARTO_DATABASE.CARTO.trajectory_clip(geom ARRAY, t ARRAY, polygon GEOGRAPHY)
RETURNS ARRAY
LANGUAGE PYTHON
RUNTIME_VERSION = 3.11
PACKAGES = ('numpy','pandas', 'geopandas','movingpandas', 'shapely')
HANDLER = 'udf'
AS $$
import numpy as np
import pandas as pd
import geopandas as gpd
import movingpandas as mpd
import shapely
from shapely.geometry import shape, mapping, Point, Polygon
from shapely.validation import make_valid
from datetime import datetime, timedelta

def udf(geom, t, polygon):
    valid_df = pd.DataFrame(geom, columns=['geometry'])
    valid_df['t'] = pd.to_datetime(t)
    valid_df['geometry'] = valid_df['geometry'].apply(lambda x:shapely.wkt.loads(x))
    gdf = gpd.GeoDataFrame(valid_df, geometry='geometry', crs='epsg:4326')
    gdf = gdf.set_index('t')
    traj = mpd.Trajectory(gdf, 1)
    traj_sm = traj.clip(shape(polygon))
    if len(traj_sm.trajectories)>0:
        res = traj_sm.to_point_gdf()
        res['geometry'] = res['geometry'].apply(lambda x: shapely.wkt.dumps(x))
        return res.reset_index().values
    else:
        return []
$$;
