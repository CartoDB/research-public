#%matplotlib inline
import matplotlib
import matplotlib.pyplot as plt
from matplotlib.ticker import FuncFormatter
from matplotlib.ticker import FormatStrFormatter
import matplotlib.colors as colors
import matplotlib.cm as cm
import seaborn as sns
import matplotlib.ticker as ticker
import matplotlib.dates as mdates
from matplotlib import rcParams
from matplotlib import rc

import sys 
import importlib
import os
import os.path
import glob
import pathlib
from decimal import Decimal
import random
import logging
import json
from jsonseq.decode import JSONSeqDecoder
from functools import partial
from functools import reduce
import gzip
import csv
from collections import defaultdict

from google.cloud import storage
from google.cloud import bigquery

import pandas as pd
import numpy as np
from numpy import median
import numpy.ma as ma

from sklearn.ensemble import RandomForestRegressor, GradientBoostingRegressor
from sklearn.metrics import r2_score, mean_squared_error
from sklearn.model_selection import train_test_split,cross_val_score,LeaveOneGroupOut
from sklearn.preprocessing import StandardScaler, QuantileTransformer
from sklearn.model_selection import GridSearchCV
import pickle
from scipy.stats import pearsonr
from scipy.stats import wasserstein_distance
from scipy.stats import chisquare

import cartoframes
from cartoframes.auth import set_default_credentials, Credentials
from cartoframes import read_carto
from cartoframes import to_carto
from cartoframes.viz import *
from cartoframes.data.observatory import Dataset
from cartoframes.viz import Layout

import rtree
import geopandas as gpd
from geopandas import GeoDataFrame
import fiona
import shapely
from shapely import wkt
from shapely import wkb
import shapely.ops as ops
from shapely.geometry import shape, mapping, Point, Polygon, box
from shapely.ops import nearest_points
from shapely.ops import cascaded_union
from scipy.spatial import ConvexHull
from shapely.geometry import MultiPoint
from shapely.wkt import loads
from scipy.spatial import cKDTree
import pyproj    
from pyproj import Proj
import utm
from datetime import datetime, timedelta
from datetime import date
import pytz
from tzwhere import tzwhere
import mercantile
from pygeotile.tile import Tile
from tiletanic import tilecover
from tiletanic import tileschemes
tiler = tileschemes.WebMercator()

import warnings
warnings.filterwarnings('ignore')
pd.options.mode.chained_assignment = None
np.random.seed(101)
