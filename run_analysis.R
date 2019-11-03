#############################################################
##                                                          #
## RUN ANALYSIS                                             #
##                                                          #
## GETTING AND CLEANING DATA COURSE PROJECT                 #
##                                                          #
#############################################################

#######################################################
## OVERVIEW AND ANY ISSUES
#######################################################

# Script for the Coursera Getting and Cleand Data course project

# ISSUE WITH SCRIPT
# None



 

######################################################
## LOADING REQUIRED LIBRARIES AND SET WORK DIRECTORY
######################################################
library(rmarkdown)
library(dplyr)
library(data.table)
library(reshape2)

setwd("c:/rstudio/learning/rvdatascience/gitCoursera/course 3 - Getting and Cleaning Data") #set workingn directory
# getwd()





#######################################################
##  GET SOURCE DATA
#######################################################
# if(!file.exists("data/")){dir.create("data/")}
# fileurl = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
# download.file(fileurl,
#               destfile = "data/dataset.zip",
#               mode = "wb")
# 

fileurl = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipfile <- "data/UCI dataset.zip"

if(!file.exists(zipfile)){
  download.file(fileurl,
                destfile = zipfile,
                mode = "wb") +
    unzip(zipfile,exdir = "data")  # ignore the error message
    }





#######################################################
##  READ TRAINING AND TEST DATA
#######################################################

# TRAINING FILES
train.subject <- read.table("data/UCI HAR Dataset/train/subject_train.txt", header = FALSE)
train.set <- read.table("data/UCI HAR Dataset/train/X_train.txt", header = FALSE)
train.labels <- read.table("data/UCI HAR Dataset/train/y_train.txt", header = FALSE)

# TEST FILES
test.subject <- read.table("data/UCI HAR Dataset/test/subject_test.txt", header = FALSE) 
test.set <- read.table("data/UCI HAR Dataset/test/X_test.txt", header = FALSE) # Test data set
test.labels <- read.table("data/UCI HAR Dataset/test/y_test.txt", header = FALSE) # Test labels

activity.labels <- fread("data/UCI HAR Dataset/activity_labels.txt",colClasses = 'factor')[,2]
features <- read.table("data/UCI HAR Dataset/features.txt", sep = "", header = FALSE)


#  ALL REQUIRED DATA HAS NOW BEEN READ INTO R





#########################################################################
##  LABEL DATA SET WITH DESCRIPTIVE VARIABLE NAMES (STEP 4)
#########################################################################

# Appropriately label the data set with descriptive variable names.

# NAME COLUMNS ON TRAIN AND TEST DATA SETS
names(train.set) <- features$V2
names(test.set) <- features$V2
names(train.subject) <- "subject"
names(test.subject) <- "subject"





#########################################################################
##  EXTRACT ONLY THE VARIABLES MEAN AND STANDARD DEVIATION (STEP 2)
#########################################################################

# Extracts only the measurements on the mean and standard deviation for each measurement.

# CREATE FILTER TO SELECT ONLY COLUMNS WITH MEAN OR STANDARD 
column.filter <- grepl("mean|Mean|std", features$V2) 

# FILTER THE TABLE TO ONLY INCLUDE THE VARIABLES MEAN AND STANDARD DEVIATION
train.set <-  train.set[, column.filter] #syntax - filter [by row, or by column]
test.set <- test.set[, column.filter] #syntax - filter [by row, or by column]





#########################################################################
##  NAME THE ACTIVITIES IN THE DATA SET (STEP 3)
#########################################################################

# Uses descriptive activity names to name the activities in the data set

train.labels[,2] <- activity.labels[train.labels[,1]] # inserts descriptive labels in column 2 similar to a vlookup
names(train.labels) <- c("activity.id","activity.name")
test.labels[,2] <- activity.labels[test.labels[,1]] # inserts descriptive labels in column 2 similar to a vlookup
names(test.labels) <- c("activity.id","activity.name")





#########################################################################
##  MERGE THE TRAINING AND TEST DATA SETS (STEP 1)
#########################################################################

# Merges the training and test sets to create one data set.

# Merging all of the train data sets
data.train <- cbind(as.data.table(train.subject),train.labels, train.set) # appends the columns two one table

# Merging all of the test data sets
data.test <- cbind(as.data.table(test.subject),test.labels, test.set) # appends the columns two one table


# Merging the full train and full test data sets to one large data set
data.merged <- rbind(data.train, data.test) # appends the rows into one consolidated table

# ncol(data.merged) # check column count, there should be 89
# nrow(data.merged) # check row count 10,299

# Removing tables no longer required to save memory
rm(train.subject, train.set, data.train, features, activity.labels, train.labels, test.subject, test.labels, test.set, data.test)





#########################################################################
## CREATE INDEPENDENT TIDY DATA SET (STEP 5)
#########################################################################

# Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Creating a vector of column names for the new table
columns <- c("subject", "activity.id", "activity.name")

# Creating a vector of column names/variables to pivot
data.columns  <- setdiff(colnames(data.merged), columns)

# Pivot the data
data.melting <- melt(data.merged, id = columns, measure.vars = data.columns)

# Aggregate and calculate the mean 
data.output <- dcast(data.melting, subject + activity.name ~ variable, mean)

# Export data output to a file.
if(!file.exists("output/")){dir.create("output/")}
write.table(data.output, 
            file = "output/Processed data.txt",
            row.names = FALSE)




#######################################################
##  END OF SCRIPT
#######################################################







