trimmDF<-function(data){
      library(dplyr)
      id<-select(data,subject_id,activity)
      trim1<-select(data,contains("_mean"))
      trim1<-select(trim1,-contains("meanFreq"))
      trim2<-select(data,contains("_std"))
      cbind(id,trim1,trim2)
}