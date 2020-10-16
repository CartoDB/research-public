from requirements import *
from ppca import PPCA

def str_to_geom(x):
    d = shapely.wkt.loads(x)  
    return d

def add_identity(axes, *line_args, **line_kwargs):
    identity, = axes.plot([], [], *line_args, **line_kwargs)
    def callback(axes):
        low_x, high_x = axes.get_xlim()
        low_y, high_y = axes.get_ylim()
        low = max(low_x, low_y)
        high = min(high_x, high_y)
        identity.set_data([low, high], [low, high])
    callback(axes)
    axes.callbacks.connect('xlim_changed', callback)
    axes.callbacks.connect('ylim_changed', callback)
    return axes

def pseudo_r2score(y,ypred):
    res = ypred-y
    vary = np.sum((y - y.mean())**2)
    tse = np.sum(res**2)
    score = 1-tse/vary
    
    return(np.round(score,2))

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

    ax.axhline(y= cum_var_exp[np.where(cum_var_exp > 0.8)[0][0]],c="black",linewidth=1,linestyle = '--',zorder=0)
    #ax.legend(loc='best', fontsize = textsize)

    plt.suptitle(title, x = 0.53, fontsize=textsize, weight='bold')

def plot_pc_corr(data, features, textsize = 20, title = 'PC correlation scores with the 10 most correlated variables'):

    pca_corr = []
    for j in range(4):
        pca_j_corr = []
        for i in features:
            pca_j_corr.append([i.upper().replace('_',' '),  ma.corrcoef(ma.masked_invalid(data['pc_' + str(j)]), ma.masked_invalid(data[i]))[0,1]])
        pca_j_corr = pd.DataFrame(pca_j_corr, columns=['vars','cor'])
        pca_j_corr = pca_j_corr.iloc[pca_j_corr['cor'].abs().argsort()][::-1]
        pca_j_corr.set_index('vars', inplace = True)
        pca_corr.append(pca_j_corr)  

    fig, ax = plt.subplots(figsize=(20,10),  nrows =2, ncols = 2)
    l = 0
    for i in range(2):
        for j in range(2):

            absmax = np.abs(pca_corr[l]["cor"][:10].values).max()
            norm = plt.Normalize(-absmax, absmax)
            cmap = plt.get_cmap("coolwarm")
            colors = cmap(norm(pca_corr[l]["cor"][:10].values))

            pca_corr[l]['cor'][:10].plot(kind='barh', color=colors, zorder=2, width=0.9, legend = False, ax = ax[i][j])

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

            ax[i][j].set_xlabel("Correlation", fontsize = textsize, labelpad=10, weight='bold', size=12)
            ax[i][j].set_ylabel("Variable", fontsize = textsize, labelpad=10, weight='bold', size=12)
            ax[i][j].set_title("PC" + str(l), fontsize=textsize, weight='bold', size=12)
            l = l + 1
            
    plt.suptitle(title, x = 0.53, fontsize=textsize, weight='bold')
    fig.tight_layout(rect=[0, 0.03, 1, 0.95])
    
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
    
def Variogram_plot(v, fig_title=None, axes=None, grid=False, show=False, hist=True):
        """Variogram Plot
        Plot the experimental variogram, the fitted theoretical function and
        an histogram for the lag classes. The axes attribute can be used to
        pass a list of AxesSubplots or a single instance to the plot
        function. Then these Subplots will be used. If only a single instance
        is passed, the hist attribute will be ignored as only the variogram
        will be plotted anyway.
        Parameters
        ----------
        axes : list, tuple, array, AxesSubplot or None
            If None, the plot function will create a new matplotlib figure.
            Otherwise a single instance or a list of AxesSubplots can be
            passed to be used. If a single instance is passed, the hist
            attribute will be ignored.
        grid : bool
            Defaults to True. If True a custom grid will be drawn through
            the lag class centers
        show : bool
            Defaults to True. If True, the show method of the passed or
            created matplotlib Figure will be called before returning the
            Figure. This should be set to False, when used in a Notebook,
            as a returned Figure object will be plotted anyway.
        hist : bool
            Defaults to True. If False, the creation of a histogram for the
            lag classes will be suppressed.
        Returns
        -------
        matplotlib.Figure
        """
        # get the parameters
        _bins = v.bins
        _exp = v.experimental
        x = np.linspace(0, np.nanmax(_bins), 100)  # make the 100 a param?

        # do the plotting
        if axes is None:
            if hist:
                fig = plt.figure(figsize=(9,6))
                ax1 = plt.subplot2grid((5, 1), (1, 0), rowspan=4)
                ax2 = plt.subplot2grid((5, 1), (0, 0), sharex=ax1)
                fig.subplots_adjust(hspace=0.5)
            else:
                fig, ax1 = plt.subplots(1, 1, figsize=(9, 4))
                ax2 = None
        elif isinstance(axes, (list, tuple, np.ndarray)):
            ax1, ax2 = axes
            fig = ax1.get_figure()
        else:
            ax1 = axes
            ax2 = None
            fig = ax1.get_figure()

        # apply the model
        y = v.transform(x)

        # handle the relative experimental variogram
        if v.normalized:
            _bins /= np.nanmax(_bins)
            y /= np.max(_exp)
            _exp /= np.nanmax(_exp)
            x /= np.nanmax(x)

        # ------------------------
        # plot Variograms
        ax1.plot(_bins, _exp, marker=".", color='coral', markersize=15, linestyle='None')
        ax1.plot(x, y, 'mediumblue', linewidth=1)
        ax1.set_facecolor('white')

        # ax limits
        if v.normalized:
            ax1.set_xlim([0, 1.05])
            ax1.set_ylim([0, 1.05])
        if grid:
            ax1.grid('off')
            ax1.vlines(_bins, *ax1.axes.get_ybound(), colors=(.85, .85, .85),
                       linestyles='dashed',linewidth=0.5)
        # annotation
        ax1.axes.set_ylabel('semivariance (%s)' % v._estimator.__name__, weight='bold', fontsize = 15)
        ax1.axes.set_xlabel('Lag (-)',weight='bold', fontsize = 15)
        ax1.tick_params(axis="both", direction="in", which="both", left=True, bottom=True, labelsize = 12.5, length = 10)
      
        # ------------------------
        # plot histogram
        if ax2 is not None and hist:
            # calc the histogram
            _count = np.fromiter(
                (g.size for g in v.lag_classes()), dtype=int
            )

            # set the sum of hist bar widths to 70% of the x-axis space
            w = (np.max(_bins) * 0.7) / len(_count)

            # plot
            ax2.bar(_bins, _count, width=w, align='center', color='mediumblue')

            # adjust
            plt.setp(ax2.axes.get_xticklabels(), visible=False)
            ax2.axes.set_yticks(ax2.axes.get_yticks()[1:])

            # need a grid?
            if grid:
                ax2.grid('off')
                ax2.vlines(_bins, *ax2.axes.get_ybound(),
                           colors=(.85, .85, .85), linestyles='dashed',linewidth=0.5)

            # anotate
            ax2.axes.set_ylabel('N', weight='bold', fontsize = 15)
            ax2.set_facecolor('white')
            ax2.tick_params(axis="y", direction="in", which="both", left=True, labelsize = 12.5, length = 10)
            
        plt.title(fig_title, weight='bold', fontsize = 15)
        return fig