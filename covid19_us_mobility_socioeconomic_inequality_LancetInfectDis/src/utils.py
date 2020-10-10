from src_import.requirements import *
from src_import.ppca import PPCA

#def get_data_from_google_storage_nokey(blob_name, dir_in, dir_out):

#    if(os.path.exists(dir_out + dir_in)):
#        pass
#    else:
#        # Path to the object in Google Cloud Storage that you want to copy
#        path_gcs_object = "gs://" + blob_name + "/" + dir_in
#        print(path_gcs_object)
#        # Copy the file from Google Cloud Storage to Datalab
#        !gsutil cp -r $path_gcs_object $dir_out

 
def get_indexes_max_value(l):
    max_value = max(l)
    if l.count(max_value) > 1:
        return [i for i, x in enumerate(l) if x == max(l)]
    else:
        return l.index(max(l))

def map_dict_to_bq_schema(df):

    dtypes_bigquery = {'float64':'FLOAT', 
                    'object':'STRING', 
                    'int64':'INTEGER',
                    'bool': 'BOOLEAN',
                    'bytes': 'BYTES'}
    
    source_dict = list()
    for column, dtype in df.dtypes.items():
        column = column.replace('-', '_').replace('.', '')
        if column == 'geometry_geojson':
            source_dict.append('geometry_geojson:GEOGRAPHY'.format(column, dtypes_bigquery[dtype.name]))
        else:
            source_dict.append('{}:{}'.format(column, dtypes_bigquery[dtype.name]))
    source_dict = {k:v for k,v in (x.split(':') for x in source_dict)}
    schema_keys = list(source_dict.keys())
    
    # SchemaField list
    schema = []

    # Iterate the existing dictionary
    for key, value in source_dict.items():

        try:
            schemaField = bigquery.SchemaField(key, value) # NULLABLE BY DEFAULT
        except KeyError:

            # We are expecting a REPEATED field
            if value and len(value) > 0:
                schemaField = bigquery.SchemaField(key, value, mode='REPEATED') # REPEATED

        # Add the field to the list of fields
        schema.append(schemaField)

        # If it is a STRUCT / RECORD field we start the recursion
        if schemaField.field_type == 'RECORD':

            schemaField._fields = map_dict_to_bq_schema(value)

    # Return the dictionary values
    return schema, schema_keys
  
def upload_local_directory_to_gcs(local_path, bucket, gcs_path):
    """Recursively copy a directory of files to GCS.

    local_path should be a directory and not have a trailing slash.
    """
    assert os.path.isdir(local_path)
    for local_file in glob.glob(local_path + '/**'):
        print(local_file)
        if not os.path.isfile(local_file):
            continue
        remote_path = os.path.join(gcs_path, local_file[0 + len(local_path) :])
        blob = bucket.blob(remote_path)
        blob.upload_from_filename(local_file)
    
def upload_df_from_gcs_to_bigquery(table_id, dataset_ref, client, bucket_name, blob_name, schema=None):

    logging.info("[Table ID] {}".format(table_id))
    table_ref = dataset_ref.table(table_id)
    logging.info("[Set Up Table Reference] {}".format(table_ref))

    GS_URL = 'gs://{}/{}'.format(bucket_name, blob_name)
    print(GS_URL)
    
    job_config = bigquery.LoadJobConfig()
    if schema is not None:
        job_config.schema = schema
    else:
        job_config.autodetect = True
        
    job_config.skip_leading_rows = 1
    job_config.source_format = 'CSV'
    job_config.write_disposition = 'WRITE_EMPTY'
    load_job = client.load_table_from_uri(
                        GS_URL, 
                        table_ref, 
                        job_config=job_config)

    logging.info("[Running] Job {}".format(load_job.job_id))
    load_job.result()
    logging.info("[Done] Job {}".format(load_job.job_id))
    destination_table = client.get_table(dataset_ref.table(table_id))
    logging.info("[INFO] Table {} Has {} Rows".format(table_id, destination_table.num_rows))
    
def upload_tsv_from_gcs_to_bigquery(table_id, dataset_ref, client, bucket_name, blob_name, schema=None):

    logging.info("[Table ID] {}".format(table_id))
    table_ref = dataset_ref.table(table_id)
    logging.info("[Set Up Table Reference] {}".format(table_ref))

    GS_URL = 'gs://{}/{}'.format(bucket_name, blob_name)
    print(GS_URL)
    
    job_config = bigquery.LoadJobConfig()
    if schema is not None:
        job_config.schema = schema
    else:
        job_config.autodetect = True
        
    job_config.skip_leading_rows = 1
    job_config.source_format = 'TSV'
    job_config.field_delimiter='\t' 
    job_config.write_disposition = 'WRITE_EMPTY'
    load_job = client.load_table_from_uri(
                        GS_URL, 
                        table_ref, 
                        job_config=job_config)

    logging.info("[Running] Job {}".format(load_job.job_id))
    load_job.result()
    logging.info("[Done] Job {}".format(load_job.job_id))
    destination_table = client.get_table(dataset_ref.table(table_id))
    logging.info("[INFO] Table {} Has {} Rows".format(table_id, destination_table.num_rows))
    
def upload_df_to_bigquery(df, table_id, dataset_ref, client, schema=None):
    logging.info("[Table ID] {}".format(table_id))
    table_ref = dataset_ref.table(table_id)
    logging.info("[Set Up Table Reference] {}".format(table_ref))
    
    job_config = bigquery.LoadJobConfig()
    if schema is not None:
        job_config.schema = schema
    else:
        job_config.autodetect = True

    load_job = client.load_table_from_dataframe(
        df,
        table_ref,
        location='US',
        job_config=job_config) 
    
    logging.info("[Running] Job {}".format(load_job.job_id))
    load_job.result()
    logging.info("[Done] Job {}".format(load_job.job_id))
    destination_table = client.get_table(dataset_ref.table(table_id))
    logging.info("[INFO] Table {} Has {} Rows".format(table_id, destination_table.num_rows))
    
def upload_table_from_bigquery_to_gcs(table_id, dataset_ref, client, bucket_name, blob_name):
    
    logging.info("[Table ID] {}".format(table_id))
    table_ref = dataset_ref.table(table_id)
    logging.info("[Set Up Table Reference] {}".format(table_ref))

    GS_URL = 'gs://{}/{}'.format(bucket_name, blob_name)
    print(GS_URL)
    
    load_job = client.extract_table(
        table_ref,
        GS_URL,
        # Location must match that of the source table.
        location="US"
    )
    # API request
    load_job.result()  # Waits for job to complete.

    logging.info("[Running] Job {}".format(load_job.job_id))
    load_job.result()
    logging.info("[Done] Job {}".format(load_job.job_id))
    
def create_gcs_bucket(client, bucket_name):
    """Creates a new bucket"""
    bucket = client.create_bucket(bucket_name)
    print("Created bucket {}.{}".format(client.project, bucket_name))
    
def create_bq_dataset(client, dataset_id, location = "US"):
    """Creates a new dataset"""
    dataset = client.dataset(dataset_id)

    # Specify the geographic location where the dataset should reside.
    dataset.location = location

    # Send the dataset to the API for creation.
    # Raises google.api_core.exceptions.Conflict if the Dataset already
    # exists within the project.
    dataset = client.create_dataset(dataset)  # API request
    print("Created dataset {}.{}".format(client.project, dataset.dataset_id))
    
def wkt_to_geojson(wkt):
    shapely_geom = loads(wkt)
    shapely_geojson =json.loads(gpd.GeoSeries([shapely_geom]).to_json())['features'][0]['geometry']

    return str(shapely_geojson)
    
def draw_corrm(df):
    sns.set(style="white")

    # Compute the correlation matrix
    corr = df.corr()

    # Generate a mask for the upper triangle
    mask = np.zeros_like(corr, dtype=np.bool)
    mask[np.triu_indices_from(mask)] = True

    # Set up the matplotlib figure
    fig, ax = plt.subplots(figsize=(11, 9))

    # Generate a custom diverging colormap
    cmap = sns.diverging_palette(220, 10, as_cmap=True)

    # Draw the heatmap with the mask and correct aspect ratio
    sns.heatmap(corr, mask=mask, cmap=cmap, center=0,
                square=True, linewidths=.5, cbar_kws={"shrink": .5}, vmin=-1, vmax=1)

def lonlat_to_quad(lon, lat, zoom=17):
    try:
        return Tile.for_latitude_longitude(lat, lon, zoom=zoom).quad_tree
    except:
        pass

def str_to_geom(x):
    d = shapely.wkt.loads(x)  
    return d

def strb_to_geom(x):
    d = wkb.loads(x, hex=True)
    return d

def quad_to_poly(quad):
    bbox = Tile.from_quad_tree(quad).bounds
    # min_lng, min_lat, max_lng, max_lat
    poly = Polygon.from_bounds(bbox[0][1], bbox[0][0], bbox[1][1], bbox[1][0]) 
    return poly
    
def quads_for_geom(geom,zoom):
    quads = [tiler.quadkey(t) for t in tilecover.cover_geometry(tiler,geom,zoom)]
    centroids = [ box(* tiler.bbox(tiler.quadkey_to_tile(q))).centroid for q in quads]
    return [ quad for quad,centroid in zip(quads,centroids) if geom.contains(centroid)] 

def quads_for_df(gdf,zoom):
    poly = cascaded_union(gdf.to_crs({'init': 'epsg:3857'}).geometry)
    return  quads_for_geom(poly,zoom)

def quads_for_geom_chunks(geom,zoom):
    quads = [tiler.quadkey(t) for t in tilecover.cover_geometry(tiler,geom,zoom)]
    return quads 

def quads_for_df_chunks(gdf,zoom):
    poly = cascaded_union(gdf.to_crs({'init': 'epsg:3857'}).geometry)
    return  quads_for_geom_chunks(poly,zoom)

def q1(x):
    return x.quantile(0.25)

def q2(x):
    return x.quantile(0.75)

def dayname_to_weekday(dayname):
    if dayname == "Monday":
        return 1
    if dayname == "Tuesday":
        return 2
    if dayname == "Wednesday":
        return 3
    if dayname == "Thursday":
        return 4
    if dayname == "Friday":
        return 5
    if dayname == "Saturday":
        return 6
    if dayname == "Sunday":
        return 0
    
    
def pandas_scatter(df, var1, var2, xlab = "", ylab = "", textsize = 15, title = '', pseudo_R2 = True):
    
    fig, ax = plt.subplots(figsize=(7.5,6),  nrows =1, ncols = 1)
    df.plot(kind='scatter', x=var1, y=var2, color = 'mediumblue', alpha = 0.5, ax = ax)

    ax.set_xlabel(xlab,fontsize=textsize,weight='bold')
    ax.set_ylabel(ylab,fontsize=textsize,weight='bold')
    ax.yaxis.tick_left()
    ax.xaxis.tick_bottom()  
    ax.tick_params(axis='both', which='major', pad = 10, size = 10, labelsize=textsize)

    plt.suptitle(title, x = 0.53, fontsize=textsize, weight='bold')
    fig.tight_layout(rect=[0, 0.03, 1, 0.98])
    plt.ticklabel_format(style='sci', axis='both', scilimits=(0,0))  
    add_identity(ax, color='black', ls='--',linewidth=0.5)
    
    if pseudo_R2:
        plt.text(df[var1].min()*2, df[var2].max()/5*4, 'pseudo-r2 score: ' + str(pseudo_r2score(df[var1],df[var2])), fontsize = textsize)
   
def pandas_hist(df, var, bins = 20, textsize = 10, title = ''):
    
    fig, ax = plt.subplots(figsize=(7.5,6),  nrows =1, ncols = 1)
    ax = df[var].plot(kind='hist', bins=bins, color = 'mediumblue', alpha = 0.5)

    ax.set_xlabel("",fontsize=textsize)
    ax.set_ylabel("Frequency",fontsize=textsize,weight='bold')
    ax.yaxis.tick_left()
    ax.xaxis.tick_bottom()  
    ax.tick_params(axis='both', which='major', pad = 10, size = 10, labelsize=textsize)

    plt.suptitle(title, x = 0.53, fontsize=textsize, weight='bold')
    fig.tight_layout(rect=[0, 0.03, 1, 0.98])
    plt.ticklabel_format(style='sci', axis='x', scilimits=(0,0))  

def run_ppca(data, features, ncomponents = None, min_obs = 0.1, use_corr = False):

    X = data[features]
    if ncomponents is None:
        ncomponents=len(features)
    ppca = PPCA(X,d = ncomponents, min_obs = min_obs)
    ppca.standardize()
    ppca.fit()
    scores, loadings = ppca.transform()
    explained_variance = ppca.var_exp

    pca_columns = []
    for i in range(scores.shape[1]):
        pca_columns.append('pc_{}'.format(i))
        data['pc_{}'.format(i)] = scores[:,i]
    return list([data,explained_variance])

def plot_pc_var(var_exp, cum_var_thr = 0.8, textsize = 10, title = ''):
    
    fig, ax = plt.subplots(figsize=(7.5,6.5),  nrows =1, ncols = 1)
    cum_var_exp = np.cumsum(var_exp)

    ax.bar(np.arange(len(var_exp)) +1, var_exp, alpha=0.5, color = 'mediumblue',
            align='center', label='individual explained variance')
    ax.step(np.arange(len(var_exp)) +1, cum_var_exp, where='mid',  color = 'mediumblue',
             label='cumulative explained variance')
    ax.set_xlabel("Principal component index",fontsize=textsize, weight='bold')
    ax.set_ylabel("",fontsize=textsize)
    ax.yaxis.tick_left()
    ax.xaxis.tick_bottom()  
    ax.tick_params(axis='both', which='major', pad = 10, size = 10, labelsize=textsize)
    ax.tick_params(axis = 'x', labelsize = textsize)

    ax.axhline(y= cum_var_exp[np.where(cum_var_exp > cum_var_thr)[0][0]],c="black",linewidth=1,linestyle = '--',zorder=0)
    #ax.legend(loc='best', fontsize = textsize)

    plt.suptitle(title, x = 0.53, fontsize=textsize, weight='bold')


def plot_pc_corr(data, var_exp,  features, nrows = 3, figsize_w = 30, figsize_h = 20, var_exp_thr = 0.7, textsize = 30, title = 'PC correlation scores with the 5 most correlated variables'):
    
    from matplotlib import rcParams
    
    rcParams['xtick.labelsize'] = 20
    rcParams['ytick.labelsize'] = 20
    
    ## Read vars dictionary
    colnames_demo = pd.read_csv('../data/SAMPLE_ESTIMATES.csv')
    colnames_bus = pd.read_csv('../data/SAMPLE_BUSINESS.csv')
    colnames_demo = list(colnames_demo.set_index('FieldName').to_dict().values())
    colnames_bus = list(colnames_bus.set_index('FieldName').to_dict().values())
    
    cum_var_exp = np.cumsum(var_exp)
    ncomponents = np.where(cum_var_exp > var_exp_thr)[0][0]
    pca_corr = []
    for j in range(ncomponents):
        pca_j_corr = []
        for i in features:
            pca_j_corr.append([i.upper().replace('_',' '),  ma.corrcoef(ma.masked_invalid(data['pc_' + str(j)]), ma.masked_invalid(data[i]))[0,1]])
        pca_j_corr = pd.DataFrame(pca_j_corr, columns=['vars','cor'])
        pca_j_corr = pca_j_corr.iloc[pca_j_corr['cor'].abs().argsort()][::-1]
        pca_j_corr.set_index('vars', inplace = True)
        
        tmp_index = []
        for item in pca_j_corr.index:
            if item.replace(' DENS','') in colnames_demo[0].keys():
                if 'DENS' in item:
                    tmp_index.append(colnames_demo[0].get(item.replace(' DENS',''),item) + ' (Density)')
                else:
                    tmp_index.append(colnames_demo[0].get(item,item))
            if item.replace(' DENS','') in colnames_bus[0].keys():
                if 'DENS' in item:
                    tmp_index.append(colnames_bus[0].get(item.replace(' DENS',''),item) + ' (Density)')
                else:
                    tmp_index.append(colnames_bus[0].get(item,item))
            if item.replace(' DENS','') not in colnames_demo[0].keys() and item.replace(' DENS','') not in colnames_bus[0].keys():
                tmp_index.append(item)
        pca_j_corr.index = [i.upper().replace(' (2019A)','').replace('$', '\$') for i in tmp_index]
        pca_corr.append(pca_j_corr)
    
    fig, ax = plt.subplots(figsize=(figsize_w,figsize_h),  nrows =nrows, ncols = int(np.ceil(ncomponents/nrows)))
    l = 0
    for i in range(nrows):
        for j in range(int(np.ceil(ncomponents/nrows))):
            if l < ncomponents:
                absmax = np.abs(pca_corr[l]["cor"][:5].values).max()
                norm = plt.Normalize(-absmax, absmax)
                cmap = plt.get_cmap("coolwarm")
                colors = cmap(norm(np.array(pca_corr[l]["cor"][:5],dtype='float64')))
                pca_corr[l]['cor'][:5].plot(kind='barh', color=colors, zorder=2, width=0.9, legend = False, ax = ax[i][j])
                
                # Despine
                ax[i][j].spines['right'].set_visible(False)
                ax[i][j].spines['top'].set_visible(False)
                ax[i][j].spines['left'].set_visible(False)
                ax[i][j].spines['bottom'].set_visible(False)
                
                # Switch off ticks
                ax[i][j].tick_params(axis="both", which="both", bottom="off", top="off", labelbottom="on", left="off", right="off", labelleft="on")
                
                # Draw vertical axis lines
                vals = ax[i][j].get_xticks()
                for tick in vals:
                    ax[i][j].axvline(x=tick, alpha=0.4, color='#eeeeee', zorder=1)
                
                if i==nrows-1:
                    ax[i][j].set_xlabel("Correlation", labelpad=10, weight='bold', size=textsize)
                else:
                    ax[i][j].set_xlabel("", labelpad=10, weight='bold', size=textsize)
                ax[i][j].set_ylabel("",  labelpad=10, weight='bold', size=textsize)
                ax[i][j].set_title("PC" + str(l),  weight='bold', size=textsize)
            else:
                fig.delaxes(ax[i][j])
            l = l + 1

def draw_corrm(df):

    fig, ax = plt.subplots(figsize=(15,15))
    
    # Compute the correlation matrix
    corr = df.corr()

    # Generate a mask for the upper triangle
    mask = np.zeros_like(corr, dtype=np.bool)
    mask[np.triu_indices_from(mask)] = True

    # Generate a custom diverging colormap
    cmap = sns.diverging_palette(220, 10, as_cmap=True)

    # Draw the heatmap with the mask and correct aspect ratio
    sns.heatmap(corr, mask=mask, cmap=cmap, center=0,
                square=True, linewidths=.5, cbar_kws={"shrink": .5}, vmin=-1, vmax=1,  ax = ax)
    
    cbar = ax.collections[0].colorbar
    cbar.ax.tick_params(labelsize=20)

def compose_agg_string(row, tablename = '', suffix = ''):
    
    column_name = row['column_name']   
    agg_method = row['agg_method'].lower()
    return """{}({}.{}) AS {}""".format(agg_method,tablename, column_name, column_name + suffix)

def compose_dens_string(row, tablename = '', suffix = ''):
    
    column_name = row['column_name']   
    agg_method = row['agg_method'].lower()
    if agg_method.lower()=='sum':
        return """SAFE_DIVIDE({}.{},POPCY) AS {}""".format(tablename, column_name, column_name + suffix)
    else:
        return """{}.{}""".format(tablename, column_name)

def compose_vars_string(row, suffix = ''):
    
    column_name = row['column_name']   
    agg_method = row['agg_method'].lower()
    if agg_method.lower()=='sum':
        return """{}""".format(column_name + suffix)
    else:
        return """{}""".format(column_name)

def get_method(dataset_id, tablename_agg, tablename_dens):
    ## Get the default aggregation methods
    methods_table = Dataset.get(dataset_id).variables.to_dataframe()
    methods_table = methods_table[['column_name','agg_method','description']]
    methods_table.dropna(inplace = True)
    methods_table = methods_table[methods_table.agg_method!='__null']
    methods_table['query_string_agg'] = methods_table.apply(lambda x: compose_agg_string(x, tablename = tablename_agg, suffix = ''), axis=1)
    methods_table['query_string_dens'] = methods_table.apply(lambda x: compose_dens_string(x, tablename = tablename_dens, suffix = '_dens'), axis=1)
    methods_table['query_string_vars'] = methods_table.apply(lambda x: compose_vars_string(x, suffix = '_dens'), axis=1)
    agg_methods = ',\n'.join(methods_table['query_string_agg'].values)
    dens_methods = ',\n'.join(methods_table['query_string_dens'].values)
    vars_names = list(methods_table['query_string_vars'].values)
    return agg_methods,dens_methods,vars_names,methods_table

def movingaverage(interval, window_size):
    window= np.ones(int(window_size))/float(window_size)
    return np.convolve(interval, window, 'same')
