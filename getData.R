## Script to download a zip file from the internet to a given destination, 
## unzip it and if requested delete the downloaded file
## Parameters (listed in order of appearence):
## fileUrl - string that contains URL of the zip file
## destination - string containing the path (relative or absolute) to the directory where the zip file should be downloaded.
##                  NB: if the directory does not exist, it is created
## deleteZip - boolean; if true the zip file is deleted after unzipping

## The default parameters correspond to the data for course project of "Getting and Cleaning Data" course from Coursera

getData<-function(fileUrl="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destination="./data",
                  deleteZip=TRUE){
      # make destination directory 
      if(!file.exists(destination)) dir.create(destination,recursive=TRUE)
      destZipFile<-paste0(destination,"/","temp.zip")
      #download and unzip
      download.file(fileUrl, destfile=destZipFile, method = "curl")
      unzip(destZipFile,exdir=destination)
      # delete zip file if requsted
      if(deleteZip) file.remove(destZipFile)
      message("Data obtained successfully. The contents of the zip file:")
      list.files(destination)
}