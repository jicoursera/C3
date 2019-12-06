########################################################################
#                                                                      #
#  LOAD DATA FOR EXPLORATORY DATA ANALYSIS COURSE PROJECT 2            #
#                                                                      #
########################################################################

# ANY ISSUES WITH THIS SCRIPT?
# None, as far as I'm aware



########################################################################
# OVERVIEW
########################################################################
# This script loads the source data and required libraries 
# for the Coursera exploratory data analysis assignment, course project 2





########################################################################
# LIBRARIES 
########################################################################
require(rmarkdown) # To produce readme file
require(data.table) # Data table tool
require(ggplot2) # Charting tool
require(gridExtra)






########################################################################
## DOWNLOAD DATA
########################################################################
fileurl <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip" # removed 's' from https for the code to work
filezip <- "data/exdata_data_NEI_data.zip"

if(!file.exists("data/")){dir.create("data/")}

if(!file.exists(filezip)){
  download.file(fileurl,
                destfile = filezip,
                mode = "wb"
  ) +
    unzip(zipfile = filezip,exdir = "data")# ignore the error message
    }


########################################################################
## READ DATA
########################################################################

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")
str(NEI)
str(SCC)



