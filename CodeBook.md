# Codebook - Description of data and variables 
=================

## Outline of the experiment, data aquisition and pre-processing procedure

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals `tAcc-XYZ` and `tGyro-XYZ`. These *time domain* signals (prefix '**t**' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Then they were sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). Similarly, the acceleration signal was then separated into body and gravity acceleration signals (`tBodyAcc-XYZ` and `tGravityAcc-XYZ`) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain *Jerk signals* (`tBodyAccJerk-XYZ` and `tBodyGyroJerk-XYZ`). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (`tBodyAccMag`, `tGravityAccMag`, `tBodyAccJerkMag`, `tBodyGyroMag`, `tBodyGyroJerkMag`). 

Finally a *Fast Fourier Transform* (FFT) was applied to some of these signals producing `fBodyAcc-XYZ`, `fBodyAccJerk-XYZ`, `fBodyGyro-XYZ`, `fBodyAccJerkMag`, `fBodyGyroMag`, `fBodyGyroJerkMag`. (Note the '**f**' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

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
## Variables

The set of variables that were estimated from signals listed in previous section are: 

* mean(): Mean value
* std(): Standard deviation
* mad(): Median absolute deviation 
* max(): Largest value in array
* min(): Smallest value in array
* sma(): Signal magnitude area
* energy(): Energy measure. Sum of the squares divided by the number of values. 
* iqr(): Interquartile range 
* entropy(): Signal entropy
* arCoeff(): Autorregresion coefficients with Burg order equal to 4
* correlation(): correlation coefficient between two signals
* maxInds(): index of the frequency component with largest magnitude
* meanFreq(): Weighted average of the frequency components to obtain a mean frequency
* skewness(): skewness of the frequency domain signal 
* kurtosis(): kurtosis of the frequency domain signal 
* bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
* angle(): Angle between to vectors.

If not said otherwise, these variables were calculated over single sampling window (128 readings)

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:
```
gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean
```

The complete list of variables of each feature vector is available in 'features.txt'. There are 561 variables in total.

## Units
The units were not indicated in the original dataset. However, it is likely that the units are SI units, i.e. the acceleration is in ms<sup>-2</sup> and angular velocity ("Gyro" variables) in s<sup>-1</sup>.

It is possible that the original data used some other units, nevertheless the summary data derived later have the same units as original data - no transformation or scaling was applied.

## Additional processing

### Variable renaming
In order to be usable in R, the variable names had to be changed:

1. remove "-" from names and replace it by "_" (it improves readability)
2. remote brackets (and replace by nothing)
3. remove "," and replace by "_"
4. add additional characters (".2") to variables bearing the same name
   * e.g. `fBodyGyro_bandsEnergy_25_48.1` and `fBodyGyro_bandsEnergy_25_48.2` (variables no. 490 and 504, respectively)
5. Some variables had typo in their name (e.g. `fBodyBodyAccJerkMag_mean`): the additional "Body" was removed

### Merging
1. For both training and test data, the data for feature vector (561 colums) were merged with the column of activity and subject indicator, creating a dataset with 563 variables
2. The rows of training and test datasets were added to create one dataset with 10299 entries for 536 variables

### Trimming/Pruning

Only the variables that showed a mean or standard deviation ("std") of some signal were kept. This means to keep all variables that originally had `mean()` or `std()` in the name. The variables containing `meanFreq()` were not kept, as this observably is fundametally different from the simple mean: the former averages over the frequencies into which is signal decomposed, the latter averages over the values of signals. Also, the variables connected with the angle of average vectors were not kept as those can be easily obtained from the component values.

In total there were 66 selected variables (33 means and 33 standard deviations)

### Relabeling of activity

Activity indicator (integer 1-6) was replaced by more informative string.

### New variables
2 new variables were added to the dataset:

* **activity** - contains a string indicating the activity done by the subject
* **subject_id** - an integer between 1 and 30 indicating which subject was the source of data

### Averaging by group

A dataset was devided into 180 groups (6 activities for 30 subjects) and per-group means of all selected variables have been calculated. The variable names are composed as follows:

**[signal name]\_[type of calculation]\_[direction]**

* **[signal name]** is a string corresponding to a signal name as defined in the beginning of this code book (e.g. `tBodyAcc` denoting the body acceleration in time domain)
* **[type of calculation]** is either `TotalMean`, if the variable is a mean of a signal averaged over all measurements for a given activity of one subject, or `MeanStd` if the variable is the standard deviation averaged over all measurements for a given activity of one subject
* **[direction]** is optional argument for observables with vector components and can be X,Y,Z 

**Example:** *tGravityAcc_TotalMean_X* is the mean of the gravity acceleration in X direction that is averaged over all measurements for given activity and for given subject.
