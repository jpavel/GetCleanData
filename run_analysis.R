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