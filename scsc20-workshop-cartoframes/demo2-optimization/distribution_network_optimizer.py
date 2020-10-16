import geopandas as gpd
import numpy as np
import pandas as pd
import time

from ortools.linear_solver import pywraplp
from scipy.spatial.distance import cdist
from shapely.geometry import Polygon
from shapely.ops import cascaded_union
from tqdm import tqdm

class DistributionNetworkOptimizer:
    
    def __init__(self, centers, grid):
        self.centers = centers
        self.centers = self.centers.to_crs('epsg:25830')

        self.grid = grid
        self.grid['rep_point'] = self.grid.geometry.representative_point() #centroid
        self.grid = self.grid.set_geometry('rep_point').to_crs('epsg:25830')

        self.dist_matrix = cdist(self.centers.geometry.apply(lambda p: [p.x, p.y]).tolist(), 
                                 self.grid.geometry.apply(lambda p: [p.x, p.y]).tolist())
        self.dist_matrix = np.round(self.dist_matrix/1e3)
        
        self.no_centers, self.no_cells = np.shape(self.dist_matrix)
        
        self.solver = pywraplp.Solver('MySolver', pywraplp.Solver.CBC_MIXED_INTEGER_PROGRAMMING)
        self.result_status = -1
        self.x = [] # Assignment variables
        
        
    def solve(self):
        print('Creating model...')
        self._create_model()
        print('...model created')

        print('Solving model...')
        start = time.time()
        self.result_status = self.solver.Solve()
        end = time.time()
        if self.result_status == pywraplp.Solver.OPTIMAL:
            print('...model solved to optimality! Total elapsed time:', end - start)
            print('Optimal solution found with value', self.solver.Objective().Value())
            self.build_solution()
        else:
            print('Optimal solution not found. Status', self.result_status)
            
    
    
    def _create_model(self):
        # VARIABLES
        ## Assignment variables
        self.x = [self.solver.NumVar(0.0, 1.0, 'x_{}_{}'.format(i//self.no_cells, i%self.no_cells)) 
             for i in range(self.no_centers*self.no_cells)]
        ## Capacity excess variables
        exc = [self.solver.NumVar(0.0, 1000.0, 'exc_{}'.format(i)) for i in range(self.no_centers)]
        max_exc = self.solver.NumVar(0.0, 1000.0, 'max_exc')
        min_exc = self.solver.NumVar(0.0, 1000.0, 'min_exc')
        diff_exc = self.solver.NumVar(0.0, 1000.0, 'diff_exc')
        
        # CONSTRAINTS
        ## (1) Every cell assigned to one (and only one) distribution center
        for i in range(self.no_cells):
            ct1 = self.solver.Constraint(1.0, 1.0)
            for j in range(self.no_centers):
                ct1.SetCoefficient(self.x[self.no_cells*j+i], 1)

        ## (2.1) Definition of excess of capacity
        #TODO: Watch out! We may adjust the reference excess
        n_orders = self.grid['avg_orders'].values
        center_capacity = self.centers['capacity_w'].values 
        for j in range(self.no_centers):
            ct2 = self.solver.Constraint(0, 100)
            ct2.SetCoefficient(exc[j], -1)
            for i in range(self.no_cells):
                ct2.SetCoefficient(self.x[self.no_cells*j+i], int(n_orders[i]*100/center_capacity[j]))
        
        ## (2.2) Definition of maximum excess
        for j in range(self.no_centers):
            ct3 = self.solver.Constraint(0.0, 0.0)
            ct3.SetCoefficient(max_exc, 1)
            ct3.SetCoefficient(exc[j], -1)
            
        ## (2.3) Definition of minimum excess 
        ##       (bare in mind we'll be minimizing diff)
        for j in range(self.no_centers):
            ct4 = self.solver.Constraint(0.0, 0.0)
            ct4.SetCoefficient(min_exc, -1)
            ct4.SetCoefficient(exc[j], 1)

        ## (2.4) Definition of max - min excess difference
        ct5 = self.solver.Constraint(0.0, 0.0)
        ct5.SetCoefficient(diff_exc, -1)
        ct5.SetCoefficient(max_exc, 1)
        ct5.SetCoefficient(min_exc, -1)
        
        # OBJECTIVE FUNCTION
        ## (1) Minimize distances (prioritizing same province cells)
        objective = self.solver.Objective()
        for i in range(self.no_centers):
            for j in range(self.no_cells):
                cost = int(self.dist_matrix[i, j])
                objective.SetCoefficient(self.x[self.no_cells*i+j], cost)

        objective.SetCoefficient(diff_exc, 1000)

        objective.SetMinimization()
        
    def build_solution(self):
        sol = {}
        for i in range(self.no_centers):
            assigned_munis = []
            for j in range(self.no_cells):
                if self.x[self.no_cells*i+j].solution_value() > 0.5:
                    assigned_munis.append(j)
            sol[i] = assigned_munis
    
        self.grid['new_delivery_dc'] = ''
        for idx_center in sol:
            self.grid.loc[sol[idx_center], 'new_delivery_dc'] = self.centers.loc[idx_center, 'name']

    def build_operatinal_regions(self):
        center_names = []
        geoms = []
        
        for center in tqdm(self.grid['new_delivery_dc'].unique()):
            center_names.append(center)
            #In order to have "clean" geometries
            cu = cascaded_union(self.grid.loc[self.grid['new_delivery_dc'] == center, 'geometry'])
            geoms.append(cu)
        
        new_or = pd.DataFrame(data={'name':center_names, 'geometry':geoms})
        new_or = gpd.GeoDataFrame(new_or, crs='epsg:4326')
        return new_or
    
    def update_dist_centers(self, updated_centers):
        self.centers = updated_centers
        self.centers = self.centers.to_crs('epsg:25830')

        self.dist_matrix = cdist(self.centers.geometry.apply(lambda p: [p.x, p.y]).tolist(), 
                                 self.grid.geometry.apply(lambda p: [p.x, p.y]).tolist())
        self.dist_matrix = np.round(self.dist_matrix/1e3)
        
        self.no_centers, self.no_cells = np.shape(self.dist_matrix)
        
        self.solver = pywraplp.Solver('MySolver', pywraplp.Solver.CBC_MIXED_INTEGER_PROGRAMMING)
        self.result_status = -1
        self.x = []
        