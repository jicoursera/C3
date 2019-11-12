############################################################
##                                         
## PLOT 1                    
##                                                         
############################################################


############################################################
## OVERVIEW AND ANY ISSUES WITHIN THE SCRIPT
############################################################

#  OVERVIEW
# The overall goal of this collection of scripts, is to examine how household energy usage varies over a 2-day period in February, 2007.
# (2007-02-01 and 2007-02-02) using the base plotting system in R.

#  ISSUES:
# None




############################################
## LIBRARIES
############################################
library(data.table) #store data as tables

setwd("c:/rstudio/learning/rvdatascience/gitCoursera/Course 4 - Exploratory data analysis/") #set workingn directory
# getwd()




############################################
## DOWNLOAD, READ AND PREPARE DATA
############################################

# DOWNLOAD AND UNZIP FILE
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipfile <- "data/exdata_data_household_power_consumption.zip"
if(!file.exists(zipfile)){
  download.file(fileurl,
                destfile = zipfile,
                mode = "wb") +
    unzip(zipfile,exdir = "data") #ignore the error message
}

# IMPORT FILE
filename <- "data/household_power_consumption.txt"
dt <- as.data.table(read.table(filename, header = TRUE, sep = ";", na.strings = "?"))

# CHANGE THE DATE VARIABLE TO DATE FORMAT
dt$date <- as.Date(dt$Date, format = "%d/%m/%Y")

# REMOVE ROWS NOT WITHIN DATE RANGE
dt1 <- dt[dt$date >= "2007-02-01" & dt$date <= "2007-02-02"]


############################################
## PLOT 1: HISTOGRAM
############################################

# PLOT 1
hist(dt1$Global_active_power, main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", col = "Red")

# SAVE FILE
dev.copy(png, file = "Plot1.png", height = 480, width = 480)
dev.off()



