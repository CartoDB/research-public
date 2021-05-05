ggplot_theme <- theme_bw() + theme(panel.border = element_rect(colour = "black", fill=NA, size=1), 
                                   panel.grid.major = element_blank(),panel.grid.minor = element_blank(), 
                                   axis.line = element_line(colour = "black"),
                                   text = element_text(size=50,colour = "black"),
                                   axis.text = element_text(colour = "black"),
                                   axis.ticks.length=unit(.75, "cm"),
                                   plot.margin = margin(10, 10, 5, 5))

pseudoR2 <- function(res,y){
    tmp <- 1-sum(res^2)/sum((y-mean(y))^2)
    return(tmp)
}

bayes_pseudoR2 <- function(model, y, log_transf = NULL, index_obs=NULL){
    n <-  dim(model$marginals.fitted.values[[1]])[1]
    bayes_pseudoR2_list <- list()
    if(is.null(index_obs)) index_obs <- seq(1,length(y))
    for(i in (1:n)){
        yhat <- as.numeric(lapply(model$marginals.fitted.values, '[[', i))[index_obs]
        if(!is.null(log_transf)) yhat <- exp(yhat)
        res <- yhat - y
        var_yhat <- var(yhat)
        var_res <- var(res)
        bayes_pseudoR2_list[[i]] <- var_yhat / (var_yhat + var_res)
    }

    return(median(as.numeric(bayes_pseudoR2_list)))
}

bri.fixed.plot = function(r, together=FALSE){
    if (!require("ggplot2")) stop("Function requires ggplot2 package. Please install this first.")
    rmf = r$marginals.fixed
    cf = data.frame(do.call(rbind, rmf))
    cf$parameter = rep(names(rmf),times=sapply(rmf,nrow))
    if(together){
        p=ggplot(cf,aes(x=x,y=y,linetype=parameter))+geom_line(size = 1.3)+geom_vline(xintercept=0)+ylab("Density")
    }else{
        p = ggplot(cf,aes(x=x,y=y,color = parameter))+geom_line(size = 1.3)+
        facet_wrap(~ parameter, scales="free")+geom_vline(xintercept=0)+ylab("Density")
    }
    invisible(cf)
    mycolors <- colorRampPalette(brewer.pal(length(r$marginals.fixed), "Dark2"))(length(rmf))
    p <- p + ggplot_theme + theme(strip.background = element_blank(), text = element_text(size=60), strip.text.x = element_text(size = 50, face = "bold")) + xlab('') + theme(legend.position = "none") 
    return(p)
}                                   
                    
bri.hyperpar.plot = function(r,together=TRUE){
    if (!require("ggplot2")) stop("Function requires ggplot2 package. Please install this first.")
    irp = r$internal.marginals.hyperpar
    hrp = r$marginals.hyperpar
    hypnames = names(irp)
    iip = grep("precision",hypnames)
    for(i in 1:length(irp)){
        if(i %in% iip){
            irp[[i]] = bri.hyper.sd(irp[[i]],internal=TRUE)
        }else{
            irp[[i]] = hrp[[i]]
            hypnames[i] = names(hrp)[i]
        }
    }
    hypnames = sub("Log precision","SD",hypnames)
    hypnames = sub("the Gaussian observations","error",hypnames)
    names(irp) = hypnames
    cf = data.frame(do.call(rbind,irp))
    cf$parameter = rep(hypnames,times=sapply(irp,nrow))
    if(together){
        p=ggplot(cf,aes(x=x,y=y,linetype=parameter))+geom_line(size = 2.5)+ylab("Density")+xlab("")
    }else{
        p=ggplot(cf,aes(x=x,y=y, color = parameter))+geom_line(size = 2.5) + facet_wrap(~parameter,scales="free")+ylab("Density")+xlab("") + scale_color_manual(values=c( '#648fff','#785ef0','#dc267f','#fe6100','#ffb000'))
    }
    invisible(cf)
    p <- p + ggplot_theme + theme(strip.background = element_blank(), text = element_text(size=60), strip.text.x = element_text(size = 50, face = "bold")) + xlab('') + theme(legend.position = "none") 
    return(p)
    
}

inla.show.hyperspec = function(result)
{
    stopifnot(any(inherits(result, "inla")))
    tfile = tempfile()
    capture.output(str(result$all.hyper), file=tfile)
    all.hyper = readLines(tfile)
    unlink(tfile)
    
    all.hyper = gsub("\\.\\.", "  ", all.hyper)    
    for(r in c("inla\\.read\\.only",
               "attr\\(", "to\\.theta",
               "from\\.theta")) {
        idx = grep(r, all.hyper)
        if (length(idx) > 0) {
            all.hyper = all.hyper[-idx]
        }
    }

    cat(all.hyper, sep="\n")
    return (invisible())
}

inla_ppcheck <- function(inla.model, observed, index_obs, log_transf = NULL, scale = 100){
  
    if(is.null(inla.model$marginals.fitted.values)) stop('No fitted values to plot')
    if(any(is.na(inla.model$misc$linkfunctions$link))){ 
        warning('Fitted values from the INLA model may have been returned on the linear, rather than link scale. Use `control.predictor = list(link = 1)` to make sure all fitted values are on the natural scale.')
    }
    if(!is.null(log_transf)){
        df <- data.frame(predicted = exp(inla.model$summary.fitted.values$mean[index_obs]),
                   observed = observed,
                   lower = exp(inla.model$summary.fitted.values$`0.025quant`[index_obs]),
                   upper = exp(inla.model$summary.fitted.values$`0.975quant`[index_obs]),
                   pit = inla.model$cpo$pit[index_obs])    
    }
    else{
        df <- data.frame(predicted = inla.model$summary.fitted.values$mean[index_obs]*scale,
                   observed = observed*scale,
                   lower = inla.model$summary.fitted.values$`0.025quant`[index_obs]*scale,
                   upper = inla.model$summary.fitted.values$`0.975quant`[index_obs]*scale,
                   pit = inla.model$cpo$pit[index_obs])    
    }

    return(df)
}

ggplot_inla_ppcheck <- function(df_train,df_test, CI = FALSE, binwidth = NULL){
  
    min <- min(df_train[, c('lower', 'observed')])
    max <- max(df_train[, c('upper', 'observed')])

    plots <- list()

    plots[[1]] <- ggplot2::ggplot(df_train, ggplot2::aes_string(x = 'pit')) + 
                  ggplot2::geom_histogram(binwidth = binwidth, alpha = 0.3, fill = 'blue',color = 'blue') +
                  ggplot2::labs(y = "Frequency", x = "PIT")    
        
    plots[[2]] <- ggplot2::ggplot(df_train, ggplot2::aes_string(x = 'predicted', y = 'observed')) +
                  ggplot2::geom_point(alpha = 0.1) +
                  ggplot2::geom_abline(slope = 1, intercept = 0) +
                  ggplot2::labs(y = "Observed (train)", x = "Predicted (train)") +
                  ggplot2::lims(x = c(min, max), y = c(min, max))
    if(CI) plots[[2]] <- plots[[2]] + 
                         ggplot2::geom_segment(ggplot2::aes_string(x = 'lower', 
                                                          xend = 'upper', 
                                                          yend = 'observed'),alpha = 0.3) 
    
    plots[[3]] <- ggplot2::ggplot(df_test, ggplot2::aes_string(x = 'predicted', y = 'observed')) +
                  ggplot2::geom_point(alpha = 0.1) +
                  ggplot2::geom_abline(slope = 1, intercept = 0) +
                  ggplot2::labs(y = "Observed (test)", x = "Predicted (test)") +
                  ggplot2::lims(x = c(min, max), y = c(min, max))
    if(CI) plots[[3]] <- plots[[3]] + 
                         ggplot2::geom_segment(ggplot2::aes_string(x = 'lower', 
                                                          xend = 'upper', 
                                                          yend = 'observed'),alpha = 0.3)     
    for(i in seq(1,3)){
        labelsize = 40
        plots[[i]] <-  plots[[i]] + theme_bw(base_size = labelsize) + ggplot_theme
    }
    
    g <- arrangeGrob(plots[[1]], plots[[2]], plots[[3]], ncol=3) 
    print(g)
    return(g)
}
                                      
inla.beta.marginal.summary<- function(x){
  odds <- inla.tmarginal(function(z) exp(z)-1, x)
  q <- inla.qmarginal(p=c(0.025, 0.5, 0.975), marginal=odds)
  c("Median"=q[2]*100, "IQR"=q[3]*100-q[1]*100)
}