## Functions to convert activity ID to human readable names
## 1) function getLabelDF returns data frame that it obtains from the specified text file
##      - default settings read the activity labels from the Siemens dataset
##
## 2) function getLabel takes 2 inputs
##      - numeric value specifying the activity ID
##      - data frame where names are assigned to the numeric ID's
##    function returns string with the desription of the meaning of the activity

getLabelDF<-function(inputFile="data//UCI HAR Dataset/activity_labels.txt"){
      labels<-read.table(inputFile,stringsAsFactors = FALSE)
      labels
}

getLabel<-function(activityID,labels){
      labels[activityID,2]
}