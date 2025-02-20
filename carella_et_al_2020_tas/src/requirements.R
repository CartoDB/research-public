libraries <- c(
            'rgdal',
            'rgeos', 
            'spdep',
            'ggplot2',
            'dplyr',
            'tidyverse',
            'session',
            'data.table',
            'gridExtra',
            'INLA',
            'inlabru',
            'splines',
            'scales',
            'RColorBrewer')

CheckInstallPackages <- function(pkgs){

    #For each pkg in pkgs (attempt to load each package one at a time):

     x <- lapply(pkgs, function(pkg){

        #Load the package if available,

        if(!do.call("require", list(pkg))) {

            #Silently attempt to install into the default library
            if(pkg!='INLA' & pkg!='INLA' & pkg!='INLAutils'){
                if(pkg=='INLA'){
                        install.packages('INLA', repos=c(getOption("repos"), INLA="https://inla.r-inla-download.org/R/stable"), dep=TRUE)
                }
                if(pkg=='brinla') install_github("julianfaraway/brinla")
                if(pkg=='INLAutils') install_github('timcdlucas/INLAutils')
            }else{
                try(install.packages(pkg, lib=.Library,repos="http://cran.rstudio.com"))
            }        

            #Now attempt to load the package, catch error if it wasn't installed
            tryCatch(do.call("library", list(pkg)),
                     error = function(e) {print(paste("error installing the library", pkg))}


            )
        }
    })

}

CheckInstallPackages(libraries)