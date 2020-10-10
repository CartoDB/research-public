library(fields)
library(viridisLite)
library(RColorBrewer)

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
    p <- p + theme_bw(base_size = 25) + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
panel.background = element_blank(), axis.line = element_line(colour = "black")) + theme(strip.background = element_blank(),
      strip.text.x = element_text(size = 25, face = "bold"))+ theme(legend.position = "none") + scale_color_manual(values=mycolors)+ theme(axis.ticks.length = unit(0.5, "cm"))
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
        p=ggplot(cf,aes(x=x,y=y,linetype=parameter))+geom_line(size = 1.3)+ylab("Density")+xlab("")
    }else{
        p=ggplot(cf,aes(x=x,y=y, color = parameter))+geom_line(size = 1.3)+facet_wrap(~parameter,scales="free")+ylab("Density")+xlab("")
    }
    invisible(cf)
    p <- p + theme_bw(base_size = 25) + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
panel.background = element_blank(), axis.line = element_line(colour = "black")) + theme(strip.background = element_blank(),
      strip.text.x = element_text(size = 25, face = "bold"))+ theme(legend.position = "none") + scale_color_brewer(palette="Dark2") + theme(axis.ticks.length = unit(0.5, "cm"))
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
                                      
inla_ppcheck <- function(inla.model, observed){
  
    if(is.null(inla.model$marginals.fitted.values)) stop('No fitted values to plot')
    if(any(is.na(inla.model$misc$linkfunctions$link))){ 
        warning('Fitted values from the INLA model may have been returned on the linear, rather than link scale. Use `control.predictor = list(link = 1)` to make sure all fitted values are on the natural scale.')
    }

    df <- data.frame(predicted = inla.model$summary.fitted.values$mean[1:length(observed)],
                   observed = observed,
                   lower = inla.model$summary.fitted.values$`0.025quant`[1:length(observed)],
                   upper = inla.model$summary.fitted.values$`0.975quant`[1:length(observed)],
                   pit = inla.model$cpo$pit)
    return(df)
}

ggplot_inla_ppcheck <- function(df, CI = FALSE, binwidth = NULL){
  
    min <- min(df[, c('lower', 'observed')])
    max <- max(df[, c('upper', 'observed')])

    plots <- list()

    plots[[1]] <- ggplot2::ggplot(df, ggplot2::aes_string(x = 'pit')) + 
                  ggplot2::geom_histogram(binwidth = binwidth, alpha = 0.1) +
                  ggplot2::labs(y = "Frequency", x = "PIT")
    
    plots[[2]] <- ggplot2::ggplot(df, ggplot2::aes_string(x = 'predicted', y = 'observed')) +
                  ggplot2::geom_point(alpha = 0.1) +
                  ggplot2::geom_abline(slope = 1, intercept = 0) +
                  ggplot2::labs(y = "Observed", x = "Predicted") +
                  ggplot2::lims(x = c(min, max), y = c(min, max))
    if(CI) plots[[2]] <- plots[[2]] + 
                         ggplot2::geom_segment(ggplot2::aes_string(x = 'lower', 
                                                          xend = 'upper', 
                                                          yend = 'observed'),alpha = 0.1) 
    
    out_residuals$ID <- seq(1:dim(out_residuals)[1])
    out_residuals_long <- reshape2::melt(out_residuals[,c('predicted','observed','ID')],id.vars="ID")
    plots[[3]] <- ggplot2::ggplot(out_residuals_long) + 
                  ggplot2::stat_density(aes(x=value, color = variable),geom="line",position="identity", size = 1.3) +
                  ggplot2::labs(y = "Density", x = "") 
    
    for(i in seq(1,3)){
        labelsize = 40
       if(i!=3) plots[[i]] <-  plots[[i]] + theme_bw(base_size = labelsize) + 
                        theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),panel.background = element_blank(), axis.line = element_line(colour = "black")) +
                        theme(strip.background = element_blank(), strip.text.x = element_text(size = labelsize, face = "bold")) +
                        theme(axis.ticks.length = unit(0.75, "cm")) 
        if(i==3) plots[[i]] <-  plots[[i]] + 
                        theme_bw(base_size = labelsize) + 
                        theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),panel.background = element_blank()) +
                        theme(strip.background = element_blank(), ,axis.line = element_line(colour = "black"), strip.text.x = element_text(size = labelsize, face = "bold")) +
                        theme(axis.ticks.length = unit(0.75, "cm")) +
                        scale_color_manual(name="",
                                             values = c("darkblue","magenta"),
                                             breaks=c("predicted", "observed"),
                                             labels=c("Predicted", "Observed ")) +
                        theme(legend.position=c(.7,.75)) + theme(legend.text=element_text(size=25)) + theme(legend.key.width = unit(3,"cm"))
        }
    
    g <- arrangeGrob(plots[[1]], plots[[2]], plots[[3]], ncol=3) #generates g
    print(g)
    return(g)
}
                                      

pseudoR2 <- function(res,y){
    tmp <- 1-sum(res^2)/sum((y-mean(y))^2)
    return(tmp)
}
                                                                         
inla.beta.marginal.summary<- function(x){
  odds <- inla.tmarginal(function(z) exp(z)-1, x)
  q <- inla.qmarginal(p=c(0.025, 0.5, 0.975), marginal=odds)
  c("Median"=q[2]*100, "IQR"=q[3]*100-q[1]*100)
}