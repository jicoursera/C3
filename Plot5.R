########################################################################
#                                                                      #
#  EXPLORATORY DATA ANALYSIS FOR COURSE PROJECT 2 - PLOT 5             #
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
# PLOT 5
########################################################################
# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?
# Baltimore City, Maryland fips == "24510"
# type == "ON-ROAD"


# CREATE DATA SET
dt.NEI <- as.data.table(NEI)
dt.1 <- dt.NEI[fips==24510 & type=="ON-ROAD",
               .(emissions = sum(Emissions)),
               by = c("fips",
                      "year")]

# CREATE CHART
plot5 <-
  ggplot(data=dt.1, aes(x=year,y=emissions))+
  geom_bar(stat="identity")+
  ggtitle("Motor vehicle emission levels have decreased in Baltimore City")

ggsave("plot5.png", plot = plot5, device = "png", height = 10, width = 15)
dev.off()

