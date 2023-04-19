
library(parallel)
# Run classification ------------------------------------------------------
#Initiate cluster
cl <- makeCluster(15)


#Simulate studies (parallel)
system.time({
  clusterEvalQ(cl,{
    setwd("/data2/mvpa")
    source("mvpa_funcs.R")
    # set.seed(123)
  })
  nsims <- 1000
  cp <- parSapply(cl,1:nsims,function(i) {
    classify.subject(nvox=200,ntrials=24,nrun=8,
                     etvs=0.8,mu.alpha=1,mu.beta=0,gamma.run=1,
                     tau.alpha=1,tau.beta=0.07,rho=0,
                     boostGain=T,
                     costVal=2^0,meanCtrRuns=F,avgTrial=F)
    
  })
})
boxplot(cp,ylim=c(0,1),ylab='Classification Accuracy',col='red')

#Close cluster
stopCluster(cl)






