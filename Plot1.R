########################################################################
#                                                                      #
#  EXPLORATORY DATA ANALYSIS FOR COURSE PROJECT 2 - PLOT 1             #
#                                                                      #
########################################################################

# ANY ISSUES WITH THIS SCRIPT?
# None, as far as I'm aware



########################################################################
# OVERVIEW
########################################################################
# This script is for the Coursera exploratory data analysis assignment, course project 2
# Run the complete script to produce the chart.





########################################################################
# SET WORKING DIRECTORY AND LOAD DATA
########################################################################

# SET WORKING DIRECTORY
scriptpath <- dirname(rstudioapi::getSourceEditorContext()$path) 
setwd(scriptpath)
getwd()

# LOAD DATA
source("Load data.r") #ignore the message 'Error in download.file'





########################################################################
## PLOT 1
########################################################################
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, 
# make a plot showing the total PM2.5 emission from all sources
# for each of the years 1999, 2002, 2005, and 2008.


# CREATE DATA TABLE
dt <- as.data.table(NEI)

# SET YEAR AS FACTOR
dt$year <- as.factor(dt$year)

# CREATE AGGREGATED TABLE
dt.1 <- dt[,
           .(emissions = sum(Emissions)),
           by = c("year")]

# CREATE BAR CHART USING BASE PLOTTING SYSTEM
barplot(
  height = dt.1$emissions/10^3,
  names.arg = dt.1$year,
  xlab = "Year",
  ylab = expression('Aggregated emissions from PM2.5 (000s)'),
  main = expression('Aggregated emmissions have decreased between 1999 and 2008'),
  font.main=4,
  cex.main=2,
  col = "light blue"
)

dev.copy(png, file = "Plot1.png", height = 1000, width = 1000)
dev.off()








