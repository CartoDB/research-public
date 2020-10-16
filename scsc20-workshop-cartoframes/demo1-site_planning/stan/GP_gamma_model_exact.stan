functions{  
    matrix cov_exp_L(real sigmasq,real tausq,real pho, vector vdist, int N){
        int h = 0;
        matrix[N, N] K;

        for (j in 1:(N - 1)){
            K[j, j] = sigmasq + tausq;
                for (k in (j + 1):N){
                    h = h + 1;
                    K[j, k] = sigmasq * exp(- pho * vdist[h]);
                    K[k, j] = K[j, k];
            }
          }
          K[N, N] = sigmasq + tausq;
          return cholesky_decompose(K);
    }

    vector get_vdist(matrix coords){
        int h = 0;
        int N = dims(coords)[1];
        vector[N * (N - 1) / 2] vdist;

        for(j in 1:(N - 1)){
            for(k in (j + 1):N){
                h = h + 1;
                vdist[h] = distance(coords[j, ], coords[k, ]);
            }
        }
        return vdist;
    }
}
data {
    int N;                         //the number of observations
    int K;                         //the number of columns in the model matrix
    real y[N];                     //the response
    matrix[N,K] X;                 //the model matrix
  
    matrix[N, 2] coords;           //the coordinates matrix
    
    real sigma;
    real tau;
    real pho;
}
transformed data{
    vector[N * (N - 1) / 2] vdist;
    matrix[N, N] L; 

    vdist = get_vdist(coords);   
    L = cov_exp_L(square(sigma), square(tau), pho, vdist, N);
}
parameters {
    vector[K] betas;               //the regression parameters
    real<lower=0> inverse_phi;     //the variance parameter
    
    vector[N] eta;    
}
transformed parameters {
    vector[N] mu;                  //the expected values (linear predictor)
    vector[N] beta;                //rate parameter for the gamma distribution   

    mu = exp(X*betas + L*eta);     //using the log link 
    beta = rep_vector(inverse_phi, N) ./ mu;
}
model {  
    betas ~ cauchy(0,2.5);     		//prior for the slopes following Gelman 2008 
    inverse_phi ~ exponential(1);  // prior on inverse dispersion parameter    
    eta ~ std_normal();  
    
    y ~ gamma(inverse_phi,beta);
}
generated quantities {
    vector[N] y_rep;
    for(n in 1:N){
        y_rep[n] <- gamma_rng(inverse_phi,beta[n]); //posterior draws to get posterior predictive checks
    }
}
