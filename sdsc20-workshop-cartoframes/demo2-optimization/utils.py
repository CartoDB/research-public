from requirements import *

def load_grid(grid_type, zoom):
    spain_geom = pd.read_csv('data/spain_geom.csv')
    spain_geom['geometry'] = spain_geom['geometry'].apply(wkt.loads)
    spain_geom = gpd.GeoDataFrame(spain_geom, crs='epsg:4326')
    spain_geom = spain_geom.geometry.iloc[0][22].buffer(0.05)
    
    list_hexagons = []
    list_hex_id = []
    if str.lower(grid_type) == 'h3' or str.lower(grid_type) == 'any':
        list_hex_id = list(h3.polyfill(geo_json = mapping(spain_geom), res = zoom))
        list_hexagons = [Polygon(h3.h3_to_geo_boundary(h3_address=x, geo_json=False)) for x in list_hex_id]
    elif str.lower(grid_type) == 'qk':
        bounds = spain_geom.bounds
        list_hex_id = list(map(mercantile.quadkey, 
                               mercantile.tiles(bounds[0], bounds[1], bounds[2], bounds[3], zooms=zoom)))
        list_hexagons = list(map(lambda x:box(*mercantile.bounds(x)),
                                 mercantile.tiles(bounds[0], bounds[1], bounds[2], bounds[3], zooms=zoom)))
    
    grid = pd.DataFrame({'hex_id': list_hex_id, 'geometry':list_hexagons})
    grid = gpd.GeoDataFrame(grid, crs='epsg:4326')
    grid = grid[grid.geometry.intersects(spain_geom)]
    
    return grid

def find_closest_center(centers, orders):
    start = time.time()
    centers = centers.to_crs('epsg:25830')
    orders = orders.to_crs('epsg:25830')
    print('Projection done! Elapsed time:', time.time() - start)
    
    order_coors = []
    if isinstance(orders.geometry.iloc[0], Polygon):
        order_coors = orders.geometry.centroid.apply(lambda p: [p.x, p.y]).tolist()
    else:
        order_coors = orders.geometry.apply(lambda p: [p.x, p.y]).tolist()    
    
    dist_matrix = cdist(order_coors, centers.geometry.apply(lambda p: [p.x, p.y]).tolist())
    
    print('Distance matrix calculated! Elapsed time:', time.time() - start)
    
    
    orders['dist_dc'] = dist_matrix.min(1)
    orders['dist_dc'] = np.round(orders['dist_dc']/1e3, 2)
    orders['delivery_dc'] = centers.loc[dist_matrix.argmin(1), 'name'].tolist()
    
    centers = centers.to_crs('epsg:4326')
    orders = orders.to_crs('epsg:4326')
    
    print('Total elapsed time:', time.time() - start)
    return orders


def calculate_global_weighted_avg(orders):
    orders['dist_dc_gobal_avg'] = orders['avg_orders'] * orders['dist_dc']
    orders['dist_dc_gobal_avg'] = orders['dist_dc_gobal_avg'].sum() / orders['avg_orders'].sum()
    return orders

def assign_cluster_names(df):
    df['cluster_name'] = 'Low density'
    for cl in df.loc[df['cluster'] != '-1', 'cluster'].unique():
        cl_name = df.loc[df['cluster'] == cl, 'delivery_dc'].value_counts().idxmax()
        df.loc[df['cluster'] == cl, 'cluster_name'] = cl_name
    return df