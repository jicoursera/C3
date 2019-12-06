########################################################################
#                                                                      #
#  EXPLORATORY DATA ANALYSIS FOR COURSE PROJECT 2 - PLOT 2             #
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
source("Load data.r")





########################################################################
## PLOT 2
########################################################################
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland fips == "24510" from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.

# CREATE DATA TABLE
dt <- as.data.table(NEI)

# SET YEAR AS FACTOR
dt$year <- as.factor(dt$year)

# CREATE AGGREGATED TABLE
dt.2 <- dt[fips == "24510", #24510 is the fips code for Baltimore
           .(emissions = sum(Emissions)),
           by = c("year",
                  "fips")]

# CREATE BAR CHART USING BASE PLOTTING SYSTEM
barplot(
  height = dt.2$emissions/10^3,
  names.arg = dt.2$year,
  xlab = "Year",
  ylab = expression('Aggregated emissions from PM2.5 (000s)'),
  main = expression('Aggregated emmissions in Baltimore have decreased between 1999 and 2008'),
  font.main=4,
  cex.main=2,
  col = "green"
)


dev.copy(png, file = "Plot2.png", height = 1000, width = 1000)
dev.off()

