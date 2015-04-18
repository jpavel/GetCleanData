
run_analysis<-function(getData=FALSE){
      library(dplyr)
      # GET THE DATA 
      if(getData){
            source("getData.R")
            getData()
      }
      ## MAKE THE INPUT DF
      source("makeDF.R")
      trainDF <- makeDF()
      testDF <- makeDF(inputTag="test")
      allDF<-rbind(trainDF,testDF)
      # clean the input DF's
      rm(trainDF)
      rm(testDF)
      
      ## KEEP ONLY MEANS AND STDs
      source("trimmDF.R")
      trim_allDF<-trimmDF(allDF)
      # and clean the unneeded variable
      rm(allDF)
      trim_allDF
}

