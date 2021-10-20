## CODE ADAPTED FROM https://github.com/allentran/pca-magic/blob/master/ppca/_ppca.py
## ADD INFO: https://allentran.github.io/ppca
import os

import numpy as np
from scipy.linalg import orth


class PPCA():

    def __init__(self, data, d = None, min_obs = 0.6, use_corr = True):

        self.raw = None
        self.data = None
        self.C = None
        self.means = None
        self.stds = None
        self.eig_vals = None
        
        self.raw = data.values
        self.d = d
        self.min_obs=min_obs
        self.use_corr = use_corr
        
    def standardize(self):
        
        ## Select only variables with % of complete obs. >= min_obs
        self.raw[np.isinf(self.raw)] = np.max(self.raw[np.isfinite(self.raw)])
        valid_series = np.sum(~np.isnan(self.raw), axis=0) >= self.min_obs
        data = self.raw[:, valid_series].copy()
        
        ## Standardize the data
        if(self.use_corr == True):
        ## If PCA are computed using the correlation matrix --> standardize the data (zero mean, unit std.)
            data = (data - np.nanmean(data, axis=0))/np.nanstd(data, axis=0)   
        else:
            ## If PCA are computed using the covariance matrix --> center the data only (zero mean)
            data = data - np.nanmean(data, axis = 0)

        self.data = data
        
    def fit(self, tol=1e-4, verbose=False):

        data = self.data
        
        N = data.shape[0]
        D = data.shape[1]

        self.means = np.nanmean(data, axis=0)
        self.stds = np.nanstd(data, axis=0)

        observed = ~np.isnan(data)
        missing = np.sum(~observed)
        data[~observed] = 0

        # initial

        if self.d is None:
            self.d = data.shape[1]
        
        if self.C is None:
            C = np.random.randn(D, self.d)
        else:
            C = self.C
        CC = np.dot(C.T, C)
        X = np.dot(np.dot(data, C), np.linalg.inv(CC))
        recon = np.dot(X, C.T)
        recon[~observed] = 0
        ss = np.sum((recon - data)**2)/(N*D - missing)

        v0 = np.inf
        counter = 0

        while True:

            Sx = np.linalg.inv(np.eye(self.d) + CC/ss)

            # e-step
            ss0 = ss
            if missing > 0:
                proj = np.dot(X, C.T)
                data[~observed] = proj[~observed]
            X = np.dot(np.dot(data, C), Sx) / ss

            # m-step
            XX = np.dot(X.T, X)
            C = np.dot(np.dot(data.T, X), np.linalg.pinv(XX + N*Sx))
            CC = np.dot(C.T, C)
            recon = np.dot(X, C.T)
            recon[~observed] = 0
            ss = (np.sum((recon-data)**2) + N*np.sum(CC*Sx) + missing*ss0)/(N*D)

            # calc diff for convergence
            det = np.log(np.linalg.det(Sx))
            if np.isinf(det):
                det = abs(np.linalg.slogdet(Sx)[1])
            v1 = N*(D*np.log(ss) + np.trace(Sx) - det) \
                + np.trace(XX) - missing*np.log(ss0)
            diff = abs(v1/v0 - 1)
            if verbose:
                print(diff)
            if (diff < tol) and (counter > 5):
                break

            counter += 1
            v0 = v1

        C = orth(C)
        vals, vecs = np.linalg.eig(np.cov(np.dot(data, C).T))
        order = np.flipud(np.argsort(vals))
        vecs = vecs[:, order]
        vals = vals[order]

        C = np.dot(C, vecs)

        # attach objects to class
        self.C = C
        self.data = data
        self.eig_vals = vals
        self._calc_var()

    def transform(self, data=None):

        ## Compute loadings
        if self.C is None:
            raise RuntimeError('Fit the data model first.')
        return [self.data.dot(self.C), self.C]

    def reconstruct(self):

        ## Reproject into the original space
        if self.C is None:
            raise RuntimeError('Fit the data model first.')

        data_rec = np.dot(self.data,np.dot(self.C, self.C.T))
            
        if(self.use_corr == True):
            return((data_rec*np.nanstd(self.data, axis=0))+ np.nanmean(data_rec, axis = 0))
        else:
            return(data_rec + np.nanmean(data_rec, axis = 0))
            
    def _calc_var(self):

        if self.data is None:
            raise RuntimeError('Fit the data model first.')

        data = self.data.T

        # Compute variance
        var = np.nanvar(data, axis=1)
        total_var = var.sum()
        self.var_exp = self.eig_vals / total_var

        
    def save(self, fpath):

        np.save(fpath, self.C)
        
    def load(self, fpath):

        assert os.path.isfile(fpath)

        self.C = np.load(fpath)