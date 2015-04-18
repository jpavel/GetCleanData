## Function to run the full analysis chain using the other scripts
## 1) downloading and unzipping data using getData.R
## 2) making the data frames from the input text files using makeDF.R
## 3) merging test and train data frames
## 4) select only the variables showing mean and standard deviation with trimmDF.R
## 5) Assign human readable labels to the activiti ID's using getLabel.R and mutate function
## 6) group the pruned data set by subjects and activities using group_by function
## -> 6 activitiews X 30 subjects => 180 groups
## 7) Apply per-group mean on all variables
## 8) Change name of the variables to reflect their new content
## 9) write output text file
##
## Function takes 2 arguments:
## getData - boolean; if true, function downloads the input data from the internet. Default is false.
## outFileName - string; name of the output text file. Default is "tidySummary.txt"


run_analysis<-function(getData=FALSE,outFileName="tidySummary.txt"){
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
      
      ## CONVERT ACTIVITY IDs TO READABLE STRINGS
      source("getLabel.R")
      mylabels<-getLabelDF()
      trim_allDF<-mutate(trim_allDF,activity=getLabel(activity,mylabels))
      
      # MAKE TIDY OUTPUT
      #group
      by_act_sub<-group_by(trim_allDF,activity,subject_id)
      #make mean of all columns
      summary<-summarise_each(by_act_sub,funs(mean))
      #adapt variable names
      varNames<-colnames(summary)
      varNames<-sub("mean","TotalMean",varNames)
      varNames<-sub("std","MeanStd",varNames)
      # fix the typo in the input variable name
      varNames<-sub("BodyBody","Body",varNames)
      colnames(summary)<-varNames
      # write output
      write.table(summary, outFileName,row.names = FALSE)
      # return data frame
      summary
}

