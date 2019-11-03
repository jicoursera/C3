---
title: "Getting and Cleaning Data Coursera Course Project CodeBook"
author: "Jordan"
date: "01/11/2019"
output: 
  html_document:
    keep_md: TRUE
---

"a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md."



## Description of the Project and Variables

- Experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. 
- Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. 
- Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz were captured.
- The experiments have been video-recorded to label the data manually. 
- The dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

Further information is available at the site where the data was obtained which can be found here:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones



## Data and transformations

### Data

### Identifiers

- activity (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
- subject 

### Variables

- The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. 
- These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. 
- Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

- Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). 
- Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

- Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

- These signals were used to estimate variables of the feature vector for each pattern: -XYZ' is used to denote 3-axial signals in the X, Y and Z directions.



### Transformations

The following transformations were applied to the source data:

1. The training and test sets were merged to create one data set.

2. Only the columns containing the variables mean and standard deviation (i.e. columns containing the strings mean and std) were considered.

3. The activity identifiers (coded 1 to 6) were replaced with descriptive activity names.

5. From the data set in step 4, the final data set was created with the average of each variable for each activity and each subject.

The collection of the source data and the transformations listed above are performed by the run_analysis.R R script.  The Readme.md file contains further details of the steps involved.






