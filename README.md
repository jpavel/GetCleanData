# GetCleanData
Project for Coursera "Getting and Cleaning data" course

## Description of scripts

### getData.R
Script to download a zip file from the internet to a given destination, unzip it and if requested delete the downloaded file

Parameters (listed in order of appearence):
* `fileUrl` - *string* that contains URL of the zip file
* `destination` - *string* containing the path (relative or absolute) to the directory where the zip file should be downloaded. NB: if the directory does not exist, it is created
* `deleteZip` - *boolean*; if true the zip file is deleted after unzipping

The default parameters correspond to the data for course project of "Getting and Cleaning Data" course from Coursera, i.e.
```
> source("getData.R")
> getData()
```
will create directory `data` in your working directory and download and unzip there the data for the course project

### makeDF.R
Function to create a data frame that contains subject ID, activity ID and all 561 derived variables ("feature vector"). The input raw data (acceleration and angular velocity vectors in "Inertial Signals" directory) are not considered. Function also adds variable names as a column names in the data frame

Parameters (listed in order of appearence):
* `inputDir` - *string* that contains path to the directory where there is "train" and "test" directory
* `inputTag` - *string* that contains name of the data type to be read (either "train" or "test")

The script workflow:
1. The script reads from 3 text files and makes 3 data frames with the same amount of rows. 
2. It reads the names of variables from the text file and use them as column names.
3. It assign variable names also to the data frames with subject ID and activity ID.
4. Finally it merges all columns of 3 data frames and returns the result

The default behavior is to read in train data provided by getData() function. To get both datasets, you can do e.g.
```
> source("makeDF.R")
> trainDF <- makeDF()
> testDF <- makeDF(inputTag="test")
```
This creates 2 data frames (`trainDF` and `testDF`, respectivelly) that contain pre-processed training and test data together with subject and activity ID.


### trimDF.R
Function to keep only selected columns in the data frame. The columns to keep contain the mean and standard deviation of all variables derived from the raw acceleration and angular velocity vectors:

```
tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag
```

There are 33 variables in total ("XYZ" stands for 3 variables for 3 directions) The resulting data frame also contains subject and activity ID, so 68 variables in total

* **Note 1**: the variables like `angle(tBodyGyroMean,gravityMean)` on positions 555-561 of the feature vectord were not considered: They are angles between the mean vectors,
rather than mean themselves and can be derived from the XYZ components of mean vectors that are included in the data frame.

* **Note 2**: `-meanFreq()` variables were not considered as well - they are mean of the frequency components, i.e. of the *domain* of the function, while we are interested in the mean of the *value* of the functions.