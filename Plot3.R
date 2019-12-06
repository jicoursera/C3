########################################################################
#                                                                      #
#  EXPLORATORY DATA ANALYSIS FOR COURSE PROJECT 2 - PLOT 3             #
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
## PLOT 3
########################################################################
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable,
#  which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City?
#  Which have seen increases in emissions from 1999-2008? 
# Use the ggplot2 plotting system to make a plot answer this question.



# CREATE DATA TABLE
dt <- as.data.table(NEI)

# SET YEAR AS FACTOR
dt$year <- as.factor(dt$year)


# CREATE AGGREGATED TABLE
dt.3 <- dt[fips == "24510", #24510 is the fips code for Baltimore
           .(emissions = sum(Emissions)),
           by = c("year",
                  "fips",
                  "type")]

dt.3$type <- as.factor(dt.3$type)


# PLOT EMISSIONS BY TYPE
chart.3a <-
  ggplot(data = subset(dt.3, type == "NON-ROAD")) +
  aes(x = year, y = emissions) +
  geom_bar(stat = "identity", fill = "green") +
  scale_y_continuous(limits = c(0, 2500), name = "Emissions") +
  ggtitle("On-road emission levels decreased")

chart.3b <-
  ggplot(data = subset(dt.3, type == "NON-ROAD")) +
  aes(x = year, y = emissions) +
  geom_bar(stat = "identity", fill = "green") +
  scale_y_continuous(limits = c(0, 2500), name = "Emissions") +
  ggtitle("Non-road emission levels decreased")

chart.3c <-
  ggplot(data = subset(dt.3, type == "NONPOINT")) +
  aes(x = year, y = emissions) +
  geom_bar(stat = "identity", fill = "green") +
  scale_y_continuous(limits = c(0, 2500), name = "Emissions") +
  ggtitle("Non-point emission levels decreased")

chart.3d <-
  ggplot(data = subset(dt.3, type == "POINT")) +
  aes(x = year, y = emissions) +
  geom_bar(stat = "identity", fill = "pink") +
  scale_y_continuous(limits = c(0, 2500), name = "Emissions") +
  ggtitle("Point emission levels increased ")

require("gridExtra") # package to combine charts for comparison
grid.arrange(chart.3a,chart.3b,chart.3c,chart.3d, nrow=1)

# PRINT CHARTS TO PNG
g <- arrangeGrob(chart.3a,chart.3b,chart.3c,chart.3d, nrow=1)
ggsave("plot3.png", plot = g, device = "png", width = 20, height = 10)
dev.off()
