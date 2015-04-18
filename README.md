# GetCleanData
Project for Coursera "Getting and Cleaning data" course

## Main Script

### run_analysis.R
Function to run the full analysis chain using the other scripts (they are described below)
Analysis steps are:

1. downloading and unzipping data using `getData.R`
2. making the data frames from the input text files using `makeDF.R`
3. merging test and train data frames
4. select only the variables showing mean and standard deviation with `trimmDF.R`
5. assign human readable labels to the activities ID's using `getLabel.R` and `mutate` function
6. group the pruned data set by subjects and activities using `group_by` function
   * 6 activitiews X 30 subjects => 180 groups
7. apply per-group mean on all variables
8. change name of the variables to reflect their new content
9. write output text file


Function takes 2 arguments:
* `getData` - *boolean*; if TRUE, function downloads the input data from the internet. Default is FALSE.
* `outFileName` - *string*; name of the output text file. Default is "tidySummary.txt"

Example usage:
```
> source("run_analysis.R")
> tidyDF <- run_analysis()
# returns tidy data.frame
```
## Other helping scripts

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

* **Note 3**: function uses `select` function from `dplyr` package, so please make sure it is installed (`install.packages("dplyr")`) 

Example usage:
```
> source("trimmDF.R")
> trimmedDF<- trimmDF(myDF)
```

## getLabel.R
Functions to convert activity ID to human readable names.

1. function `getLabelDF` returns data frame that it obtains from the specified text file (only input)
     - default settings read the activity labels from the Siemens dataset

2. function `getLabel` returns string with the desription of the meaning of the activity and takes 2 inputs
   * *numeric* value specifying the activity ID
   * *data.fram*e where names are assigned to the numeric ID's

Example usage:
```
> source("getLabel.R")
> myLabels<-getLabelDF()
> getLabel(1,myLabels)
[1] "WALKING"
```

