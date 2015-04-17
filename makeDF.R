## Function to create a data frame that contains subject ID, activity ID and all
## 561 derived variables ("feature vector"). 
## The input raw data (acceleration and angular velocity vectors in "Inertial Signals" directory) are not considered
## function also adds variable names as a column names in the data frame

## There are 2 parameters:
## inputDir: string that contains path to the directory where there is "train" and "test" directory
## inputTag: string that contains name of the data type to be read (either "train" or "test")
##
## The script first reads from 3 text files and makes 3 data frames with the same amount of rows
## Then it reads the names of variables from the text file and use them as column names
## Then it assign variable names also to the data frames with subject ID and activity ID
## Finally it merges all columns of 3 data frames and returns the result
##
## The default behavior is to read in train data provided by getData() function


makeDF <- function(inputDir="data//UCI HAR Dataset/", inputTag="train"){
      # check of inputs
      if(!(inputTag=="train"|inputTag=="test")) 
            warning("Non-standard input tag! Recommended values are \"train\" or \"test\". ")
      # reading 3 files
      train_main<-read.table(paste0(inputDir,"/",inputTag,"/X_",inputTag,".txt"),colClasses = "numeric")
      train_act<-read.table(paste0(inputDir,"/",inputTag,"/y_",inputTag,".txt"),colClasses = "numeric")
      train_sub<-read.table(paste0(inputDir,"/",inputTag,"/subject_",inputTag,".txt"),colClasses = "numeric")
      # reading variable names
      var_names<-read.table(paste0(inputDir,"/features.txt"),stringsAsFactors = FALSE)
      names<-var_names[,2]
      # assigning variable names to columns
      colnames(train_main)<-names
      colnames(train_act)<-c("activity")
      colnames(train_sub)<-c("subject_id")
      # merging
      trainDF<-cbind(train_sub,train_act,train_main)
}