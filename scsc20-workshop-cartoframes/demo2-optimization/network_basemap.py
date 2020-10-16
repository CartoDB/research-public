from requirements import *
from utils import *

class NetworkBasemap:
    
    def __init__(self, dc_copy, orders_grid_copy):
        self.dc_copy = dc_copy
        self.orders_grid_copy = orders_grid_copy

    def update_dataframes(self, add, remove):
        if add != 'Select a cell':
            geometry = self.orders_grid_copy[self.orders_grid_copy['hex_id'] == add].geometry.iloc[0].centroid
            self.dc_copy = self.dc_copy.append(pd.DataFrame(data={'name':['Manual'], 
                                                                  'tipo':['Manual'], 
                                                                  'geometry':[geometry],
                                                                  'coste':0.87}), 
                                               ignore_index=True)
        if remove != 'Select a center':
            self.dc_copy = self.dc_copy.drop(self.dc_copy[self.dc_copy['name'] == remove].index[0]).reset_index(drop=True)


        if add != 'Select a cell' or remove != 'Select a center':
            self.orders_grid_copy.drop(columns=['dist_dc', 'delivery_dc'], inplace=True)
            self.orders_grid_copy = find_closest_center(self.dc_copy, self.orders_grid_copy)
            self.orders_grid_copy = calculate_global_weighted_avg(self.orders_grid_copy)


    def visualize_logistics_design(self, add, remove):

        self.update_dataframes(add, remove)

        dist_linestrings = []
        for idx, row in self.orders_grid_copy.iterrows():
            dist_linestrings.append(LineString([row['geometry'].centroid.coords[0], 
                                                self.dc_copy[self.dc_copy['name'] == row['delivery_dc']].geometry.iloc[0].coords[0]]))

        df_dist = pd.DataFrame(data={'id':range(len(dist_linestrings)), 'geometry':dist_linestrings})
        df_dist = gpd.GeoDataFrame(df_dist, crs='epsg:4326')

        clear_output()
        display( 
            Map([Layer(self.orders_grid_copy,
                       style=color_bins_style('avg_orders', opacity=0.6), #, breaks=breaks),
                       default_popup_hover=False, 
                       popup_click=popup_element('hex_id', title='Cell id'),
                       legends=color_category_legend(title='# orders'),
                       widgets=[formula_widget('dist_dc_gobal_avg', 
                                   operation='avg', 
                                   title='Average Distance (km)', 
                                   description='Average distance from DCs to delivery locations'),
                                formula_widget('dist_dc', 
                                   operation='max', 
                                   title='Max. Distance (km)', 
                                   description='Max. distance from DCs to delivery locations'),
                                histogram_widget('dist_dc', 
                                     title='DC - Delivery Location Distance Distribution', 
                                     description='Select a range of values to filter')], 
                       encode_data=False),
                 Layer(df_dist, 
                       style=basic_style(opacity=0.8),
                       legends=basic_legend('Assignments')),
                 Layer(self.dc_copy, 
                       popup_click=popup_element('name', title='Center'),
                       legends=basic_legend('Distribution Centers'),
                       widgets=[formula_widget('coste', 
                                   operation='sum', 
                                   title='DC Operational Cost (M€)', 
                                   description='Total DC operational cost in M€')])], 
                viewport={'zoom': 5.40, 'lat': 39.981134, 'lng': -3.938105}
               )
        )