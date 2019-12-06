########################################################################
#                                                                      #
#  EXPLORATORY DATA ANALYSIS FOR COURSE PROJECT 2 - PLOT 4             #
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
# PLOT 4
########################################################################
# Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?


#  1.CREATE DATA SET OF SCC CODES TO FILTER THE DATASET
# filter SCC codes for coal combustion-related sources 
# Note, the data set contains 'charcoal' which is wood, 'Coal' is a rock. I've only included 'Coal'.
dt.scc <- as.data.table(SCC)
dt.coal.scc.codes <- dt.scc[SCC.Level.One %like% 'Combustion' & Short.Name %like% 'Coal',
                            .(ignore = sum(Map.To,is.na=1)),
                            by = c("SCC")] 
# change column name
names(dt.coal.scc.codes) <- c("coal.SCC","ignore") 
# table of coal combustion-related SCC codes 
dt.coal.scc.codes <- merge(dt.coal.scc.codes, dt.scc, by.x = 'coal.SCC', by.y = 'SCC', all.x = TRUE)


#  2.CREATE DATA SET FOR ANALYSIS USING THE FILTERED SCC CODES
dt.NEI <- as.data.table(NEI)
dt.coal.combustion <- merge(dt.NEI,dt.coal.scc.codes, by.x = 'SCC', by.y = 'coal.SCC', all.x = FALSE) #Inner join, creating a table of only Coal combustion emmissions
dt.coal.combustion.summarised <- dt.coal.combustion[,
                                                    .(
                                                      emissions = sum(Emissions)
                                                    ),
                                                    by = c("year")
                                                    ]

options(scipen = 999) # turn off scientific notation like 1e+06 

#  3.CREATE CHART
plot4 <-
  ggplot(data=dt.coal.combustion.summarised, aes(x=year,y=emissions))+
  geom_bar(stat="identity",fill="green")+
  scale_y_continuous(name = "PM2.5 emission level")+
  scale_x_continuous(name = "Year")+
  ggtitle("Emissions from coal combustion-related sources have significantly decreased in 2008")

ggsave("plot4.png", plot = plot4, device = "png", height = 10, width = 15)
dev.off()
