## A function to keep only selected columns in the data frame
## The columns to keep contain the mean and standard deviation of all variables 
## derived from the raw acceleration and angular velocity vectors:
## 
## tBodyAcc-XYZ
## tGravityAcc-XYZ
## tBodyAccJerk-XYZ
## tBodyGyro-XYZ
## tBodyGyroJerk-XYZ
## tBodyAccMag
## tGravityAccMag
## tBodyAccJerkMag
## tBodyGyroMag
## tBodyGyroJerkMag
## fBodyAcc-XYZ
## fBodyAccJerk-XYZ
## fBodyGyro-XYZ
## fBodyAccMag
## fBodyAccJerkMag
## fBodyGyroMag
## fBodyGyroJerkMag
##
## There are 33 variables in total ("XYZ" stands for 3 variables for 3 directions)
## The resulting data frame also contains subject and activity ID
## 
## Note 1: the variables angle(tBodyGyroMean,gravityMean) on positions 555-561 of
## the feature vectord were not considered: They are angles between the mean vectors,
## rather than mean themselves and can be derived from the XYZ components of mean vectors 
## that are included
##
## Note 2: meanFreq() variables were not considered as well - they are mean of 
## the frequency components, i.e. of the DOMAIN of the function, while we are 
## interested in the mean of the value of the functions.



trimmDF<-function(data){
      library(dplyr)
      id<-select(data,subject_id,activity)
      trim1<-select(data,contains("_mean"))
      trim1<-select(trim1,-contains("meanFreq"))
      trim2<-select(data,contains("_std"))
      cbind(id,trim1,trim2)
}