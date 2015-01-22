# CodeBook.md

Getting and Cleaning Data - course project

==================================================================
Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Universit<E0> degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
==================================================================


## Summary of raw data

> The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

> The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

>For each record it is provided:
======================================

>- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
>- Triaxial Angular velocity from the gyroscope. 
>- A 561-feature vector with time and frequency domain variables. 
>- Its activity label. 
>- An identifier of the subject who carried out the experiment.

>The dataset includes the following files:
=========================================

>- 'README.txt'

>- 'features_info.txt': Shows information about the variables used on the feature vector.

>- 'features.txt': List of all features.

>- 'activity_labels.txt': Links the class labels with their activity name.

>- 'train/X_train.txt': Training set.

>- 'train/y_train.txt': Training labels.

>- 'test/X_test.txt': Test set.

>- 'test/y_test.txt': Test labels.

>The following files are available for the train and test data. Their descriptions are equivalent. 

>- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

>- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

>- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

>- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

>Notes: 
======
>- Features are normalized and bounded within [-1,1].
>- Each feature vector is a row on the text file.

>For more information about this dataset contact: activityrecognition@smartlab.ws

## Study Design

The data used in this project is part of the [UC Irvine Machine Learning Repository](https://archive.ics.uci.edu/ml/datasets.html) and was downloaded as a .zip.  The data was then processed by the run_analysis.R script as described in the Transforms section of this document.

## Variables

See the follwing files (part of the .zip archive) for a full description of variables and units:
- README.txt
- features_info.txt
- features.txt

## Transformations
1. Read in the following files:
..- features.txt
..- activity_labels.txt
..- train/subject_train.txt
..- train/X_train.txt
..- train/y_train.txt
..- test/subject_test.txt
..- test/X_test.txt
..- test/y_test.txt
2. Combine X_train and X_test into a single data set
3. Label the columns of the combined data set with the features in features.txt
4. Create a subset of the data based on column names that match the regular expressions `mean.*()` and `std.*()` per project instructions
5. Rename the columns
..- remove parentheses
..- replace hyphens with underscores
6. Bind activity labels to data set, replace integers with matching values from activity_labels.txt
7. Add subject identifiers to the data set with values from subject_train.txt and subject_test.txt

## Tidy data set

The next part of the assignment was to summarize the data and create a new tidy data set.  The new data set contains the average of each variable for each activity and each subject.  To do this, I used the dplyr library and performed the following steps:
1. Create a data set called "tidy" using the `group_by()` function, passing Subject and Activity as parameters
2. Pass this grouped data to `summarise_each()`, specifying "mean" as the argument to the "funs" parameter
3. The new values in this tidy data set represent averages of each of the variables (by subject/activity), so prefeix each column name with the string "avg_" to make it more descriptive
4. Write this final data set to the file "tidy.txt"

Sample output of tidy.txt:

```
> head(tidy)
Source: local data frame [6 x 81]
Groups: Subject

  Subject           Activity avg_tBodyAcc_mean_X avg_tBodyAcc_mean_Y
1       1             LAYING           0.2215982        -0.040513953
2       1            SITTING           0.2612376        -0.001308288
3       1           STANDING           0.2789176        -0.016137590
4       1            WALKING           0.2773308        -0.017383819
5       1 WALKING_DOWNSTAIRS           0.2891883        -0.009918505
6       1   WALKING_UPSTAIRS           0.2554617        -0.023953149
Variables not shown: avg_tBodyAcc_mean_Z (dbl), avg_tBodyAcc_std_X (dbl),
  avg_tBodyAcc_std_Y (dbl), avg_tBodyAcc_std_Z (dbl), avg_tGravityAcc_mean_X
  (dbl), avg_tGravityAcc_mean_Y (dbl), avg_tGravityAcc_mean_Z (dbl),
  avg_tGravityAcc_std_X (dbl), avg_tGravityAcc_std_Y (dbl),
  avg_tGravityAcc_std_Z (dbl), avg_tBodyAccJerk_mean_X (dbl),
  avg_tBodyAccJerk_mean_Y (dbl), avg_tBodyAccJerk_mean_Z (dbl),
  avg_tBodyAccJerk_std_X (dbl), avg_tBodyAccJerk_std_Y (dbl),
  avg_tBodyAccJerk_std_Z (dbl), avg_tBodyGyro_mean_X (dbl),
  avg_tBodyGyro_mean_Y (dbl), avg_tBodyGyro_mean_Z (dbl), avg_tBodyGyro_std_X
  (dbl), avg_tBodyGyro_std_Y (dbl), avg_tBodyGyro_std_Z (dbl),
  avg_tBodyGyroJerk_mean_X (dbl), avg_tBodyGyroJerk_mean_Y (dbl),
  avg_tBodyGyroJerk_mean_Z (dbl), avg_tBodyGyroJerk_std_X (dbl),
  avg_tBodyGyroJerk_std_Y (dbl), avg_tBodyGyroJerk_std_Z (dbl),
  avg_tBodyAccMag_mean (dbl), avg_tBodyAccMag_std (dbl),
  avg_tGravityAccMag_mean (dbl), avg_tGravityAccMag_std (dbl),
  avg_tBodyAccJerkMag_mean (dbl), avg_tBodyAccJerkMag_std (dbl),
  avg_tBodyGyroMag_mean (dbl), avg_tBodyGyroMag_std (dbl),
  avg_tBodyGyroJerkMag_mean (dbl), avg_tBodyGyroJerkMag_std (dbl),
  avg_fBodyAcc_mean_X (dbl), avg_fBodyAcc_mean_Y (dbl), avg_fBodyAcc_mean_Z
  (dbl), avg_fBodyAcc_std_X (dbl), avg_fBodyAcc_std_Y (dbl), avg_fBodyAcc_std_Z
  (dbl), avg_fBodyAcc_meanFreq_X (dbl), avg_fBodyAcc_meanFreq_Y (dbl),
  avg_fBodyAcc_meanFreq_Z (dbl), avg_fBodyAccJerk_mean_X (dbl),
  avg_fBodyAccJerk_mean_Y (dbl), avg_fBodyAccJerk_mean_Z (dbl),
  avg_fBodyAccJerk_std_X (dbl), avg_fBodyAccJerk_std_Y (dbl),
  avg_fBodyAccJerk_std_Z (dbl), avg_fBodyAccJerk_meanFreq_X (dbl),
  avg_fBodyAccJerk_meanFreq_Y (dbl), avg_fBodyAccJerk_meanFreq_Z (dbl),
  avg_fBodyGyro_mean_X (dbl), avg_fBodyGyro_mean_Y (dbl), avg_fBodyGyro_mean_Z
  (dbl), avg_fBodyGyro_std_X (dbl), avg_fBodyGyro_std_Y (dbl),
  avg_fBodyGyro_std_Z (dbl), avg_fBodyGyro_meanFreq_X (dbl),
  avg_fBodyGyro_meanFreq_Y (dbl), avg_fBodyGyro_meanFreq_Z (dbl),
  avg_fBodyAccMag_mean (dbl), avg_fBodyAccMag_std (dbl),
  avg_fBodyAccMag_meanFreq (dbl), avg_fBodyBodyAccJerkMag_mean (dbl),
  avg_fBodyBodyAccJerkMag_std (dbl), avg_fBodyBodyAccJerkMag_meanFreq (dbl),
  avg_fBodyBodyGyroMag_mean (dbl), avg_fBodyBodyGyroMag_std (dbl),
  avg_fBodyBodyGyroMag_meanFreq (dbl), avg_fBodyBodyGyroJerkMag_mean (dbl),
  avg_fBodyBodyGyroJerkMag_std (dbl), avg_fBodyBodyGyroJerkMag_meanFreq (dbl)
```
