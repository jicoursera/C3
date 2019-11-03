---
title: "Coursera Getting and Cleaning Data course project Readme"
author: "Jordan"
date: "02/11/2019"
output: 
  html_document:
    keep_md: TRUE
---


"The README that explains the analysis files is clear and understandable."

### This repository contains the following files

- Readme.md, this file provides an overview of the data set and how it was created.
- CodeBook.md, the code book which describes the variables, the data, and any transformations.
- run_analysis.R, the R script that was used to run the analysis and create the data output
- data.output.txt, the output of the analysis




### Overview of the data set
The purpose of this project is to demonstrate ability to collect, work with, and clean a data set for the Coursera course project 'Getting and Cleaning Data'. The goal is to prepare tidy data that can be used for later analysis.

The data used in this analysis is collected from the accelerometers from the Samsung Galaxy S smartphone. 

One of the most exciting areas in all of data science right now is wearable computing. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone.

[Link to download the raw data UCI Human Activity Recognition Using Smartphones](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)


#### Brief description of the 'txt' files in the UCI Data Set

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.



### Description of the script
The R script run_analysis.R transforms the raw UCI data set to produce an output file summarising the average, mean and standard deviation, for each subject and activity.

To carry out the analysis run the script in /code/run_analysis.R which performs the following actions:

1. Loads the necessary R libraries
2. Sets the working directory
3. Downloads and unzips the source data if required
3. Reads the data into R
4. Labels the train and test data set columns
5. Filters the train and test data set columns to only include the mean and standard deviation variables
6. Labels the subject and activity data sets
7. Merges the data sets to one data.table
7. Transforms the merged data.table to an independent tidy data set, containing the average of each variable (mean and standard deviation) for each subject and each activity.
8. Writes an output file of the tidy data set data.output.txt




### Licence
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
