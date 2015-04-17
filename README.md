# GetCleanData
Project for Coursera "Getting and Cleaning data" course

## Description of scripts

### getData.R
Script to download a zip file from the internet to a given destination, unzip it and if requested delete the downloaded file

Parameters (listed in order of appearence):
`fileUrl` - *string* that contains URL of the zip file
`destination` - *string* containing the path (relative or absolute) to the directory where the zip file should be downloaded.
                 NB: if the directory does not exist, it is created
`deleteZip` - *boolean*; if true the zip file is deleted after unzipping

The default parameters correspond to the data for course project of "Getting and Cleaning Data" course from Coursera, i.e.
```
> source("getData.R")
> getData()
```
will create directory `data` in your working directory and download and unzip there the data for the course project


