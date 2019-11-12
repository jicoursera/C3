---
title: "Coursera Exploratory Data Analysis"
author: "Jordan"
date: "12/11/2019"
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
The overall goal of this collection of scripts, is to examine how household energy usage varies over a 2-day period in February, 2007.
(2007-02-01 and 2007-02-02) using the base plotting system in R.
[Link to download the data from the UC Irvine Machine Learning Repository](https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip)


#### Brief description of the 'txt' files in the UCI Data Set

- 'household_power_consumption.txt': Measurements of electric power consumption in one household with a one-minute sampling rate over a period of almost 4 years. Different electrical quantities and some sub-metering values are available.




### Description of the script
The R scripts Plot 'n'.R transforms the 'household_power_consumption.txt' file into four plot outputs.

To re-create the charts, run each plot script which perform the following actions:

1. Loads the necessary R libraries
2. Sets the working directory
3. Downloads and unzips the source data if required
3. Reads the data into R
4. Creates date and time columns, and filters the data to the 1st and 2nd of February 2017.
5. Creates the charts and generates an outputfile

