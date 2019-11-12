############################################################
##                                          
## PLOT 4                     
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

# CREATE COLUMN DATETIME
dt1[, datetime := as.POSIXct(paste(date,Time), format = "%Y-%m-%d %H:%M:%S")]
#head(dt1)



############################################
## PLOT 4: COMBINATION CHART
############################################

# CREATE CHART
par(mfrow = c(2, 2)) # Set graphic parameters i.e. chart grid

plot(dt1$Global_active_power ~ dt1$datetime, type = "l", ylab = "Global Active Power", xlab = "")

plot(dt1$Voltage ~ dt1$datetime, type = "l", ylab = "Voltage", xlab = "datetime")

plot(dt1$Sub_metering_1 ~ dt1$datetime, type = "l", ylab = "Energy sub metering", xlab = "")
lines(dt1$Sub_metering_2 ~ dt1$datetime, col = "Red")
lines(dt1$Sub_metering_3 ~ dt1$datetime, col = "Blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n")

plot(dt1$Global_reactive_power ~ dt1$datetime, type = "l", ylab = "Global reactive power", xlab = "datetime")


# SAVE CHART TO FILE
dev.copy(png, file = "Plot4.png", height = 480, width = 480)
dev.off()
