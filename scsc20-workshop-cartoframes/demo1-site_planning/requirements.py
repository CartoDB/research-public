import cartoframes
from cartoframes.auth import set_default_credentials, Credentials
from cartoframes import read_carto
from cartoframes import to_carto
from cartoframes.viz import * 
from cartoframes.data.services import Geocoding
from cartoframes.data.observatory import Dataset, Catalog, Geography, Variable, Enrichment

import pandas as pd
import geopandas as gpd
from geopandas import GeoDataFrame
import shapely
from shapely import wkt
import numpy as np
import numpy.ma as ma
import random

import matplotlib.pyplot as plt
import seaborn as sns
import missingno as msno 

from sklearn import preprocessing
from sklearn.metrics import r2_score, mean_squared_error
from sklearn.model_selection import train_test_split
import statsmodels.api as sm
from skgstat import Variogram

import pystan
import pickle
import gzip

from google.cloud import bigquery

import warnings
warnings.filterwarnings('ignore')

sns.set_style("white")
np.random.seed(101)