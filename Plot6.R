########################################################################
#                                                                      #
#  EXPLORATORY DATA ANALYSIS FOR COURSE PROJECT 2 - PLOT 6             #
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
## PLOT 6
########################################################################
# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, 
# Which city has seen greater changes over time in motor vehicle emissions?

# FILTERS
# Baltimore City, Maryland fips == "24510"
# California fips == "06037"



#  CREATE DATA SET
dt.NEI <- as.data.table(NEI)
dt.NEI$type <- as.factor(dt.NEI$type)

dt.2 <- dt.NEI[fips %in% c('24510','06037') & type=="ON-ROAD",
               .(emissions = sum(Emissions)),
               by = c("fips",
                      "type",
                      "year")]

plot6.baltimore <-
  ggplot(data=subset(dt.2,fips=='24510'), aes(x=year,y=emissions))+
  geom_bar(stat="identity", fill="green")+
  scale_x_continuous(name="Year")+
  scale_y_continuous(limits = c(0,500), name = "Baltimore emissions")+
  facet_wrap("fips")+
  ggtitle("Motor vehicle emissions in Baltimore have more than halved since 1998")

plot6.LA <-
  ggplot(data=subset(dt.2,fips=='06037'), aes(x=year,y=emissions))+
  geom_bar(stat="identity", fill="pink")+
  scale_x_continuous(name="Year")+
  scale_y_continuous(limits = c(0,5000),name = "Los Angeles emissions")+
  facet_wrap("fips")+
  ggtitle("whereas, emissions in Los Angeles appear to be increasing")


grid.arrange(plot6.baltimore,plot6.LA,ncol=2)
plot6 <- arrangeGrob(plot6.baltimore,plot6.LA,ncol = 2)
ggsave("plot6.png", plot = plot6, device = "png", height = 10, width = 15)
dev.off()


