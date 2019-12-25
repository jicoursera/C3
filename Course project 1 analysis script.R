########################################################################
#
#
# REPRODUCIBLE RESEARCH: COURSE PROJECT 1                                                 
#
#
########################################################################
# issues
# None



########################################################################
# OVERVIEW
########################################################################

#  WHAT DOES THIS SCRIPT DO?
# 1. Code for reading in the dataset and/or processing the data
# 2. Creates a Histogram of the total number of steps taken each day
# 3. Calculates the Mean and median number of steps taken each day
# 4. Plots a time series of the average number of steps taken
# 5. Calculates the 5-minute interval that, on average, contains the maximum number of steps
# 6. Code to describe and show a strategy for imputing missing data
# 7. Creates a histogram of the total number of steps taken each day after missing values are imputed
# 8. Creates a panel plot comparing the average number of steps taken per 5-minute interval across weekdays and weekends






########################################################################
# LIBRARIES AND SET WORKING DIRECTORY 
########################################################################
require(rmarkdown) #notebook
require("knitr") #package to produce markdown
require(data.table) #store data as tables
require(ggplot2) #charting
require(lubridate) #dates
require(mice) #impute missing values
require(gridExtra)


# SET WORKING DIRECTORY
scriptpath <- dirname(rstudioapi::getSourceEditorContext()$path) 
setwd(scriptpath)
getwd()


########################################################################
# 1. CODE FOR READING IN THE DATASET AND/OR PROCESSING THE DATA
########################################################################

#  DOWNLOAD DATA
fileurl <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip"
filezip <- "data/repdata_data_activity.zip"

if(!file.exists("data")){dir.create("data")} #create folder for data
if(!file.exists("figures")){dir.create("figures")} #create folder for figures
if(!file.exists(filezip)){
  download.file(fileurl,
                destfile = filezip,
                mode = "wb"
  ) +
    unzip(zipfile = filezip,exdir = "data/")# ignore the error message
}


#  LOAD DATA
data.activity <- fread("data/activity.csv")
#  PROCESS TRANSFORM DATA
data.activity$date <- as.Date(ymd(data.activity$date))


# CHECKS 
names(data.activity)
dim(data.activity)
# check, there should be 17,568 observations in this dataset.
length(unique(data.activity$date)) #number of exact dates = 61 days
length(unique(data.activity$date))/7 #data is not in complete weeks
head(data.activity)
anyNA(data.activity) # is there any missing data?
# We know there are records where steps = NA
md.pattern(data.activity) #2305 records with NA
data.activity[is.na(steps),.(steps=length(steps)),by = c("date")] 
# There are 8 dates with no data
# Omitting these dates from the initial data set 




#  CREATE DATA SET EXCLUDING DATES WITHOUT DATA
data.activity2 <-
  data.activity[!is.na(steps),
                .(
                  totalsteps = sum(steps,na.rm = TRUE),
                  meanstepsperday = mean(steps,na.rm = TRUE)
                ),
                by = c("date")
                ]




########################################################################
# 2. HISTOGRAM OF THE TOTAL NUMBER OF STEPS TAKEN EACH DAY 
########################################################################

# CHART TO SENSE CHECK THE DATA (VOLUME BY DAY)
ggplot(data.activity2)+
  aes(x=date,y=totalsteps)+
  stat_summary(fun.y = sum, geom = "bar")+
  ggtitle("There are days with either very high/low volumes of steps",
          subtitle = " (days missing data excluded)")+
  scale_x_date(name = "Date")+
  scale_y_continuous(name = "Sum of steps by day")


#  HISTOGRAM
chart.step2.histogram <-
  ggplot(data.activity2, aes(totalsteps))+
  geom_histogram(bins = 15, fill="green",alpha=1/2)+
  ggtitle(label="Histogram: Around 10k steps per day occurs most frequently")+
  scale_x_continuous(name = "Total number of steps taken each day",labels = scales::comma)+  
  scale_y_continuous(name = "Frequency")

# Some notes on histograms.
# Histograms tell us 3 things:
# 1. Average or median, which indicates what statistical tools to use ....
# If the left side of a histogram resembles a mirror image of the right side, then the data are said to be symmetric. 
# In this case, the mean (or average) is a good approximation for the center of the data. 
# And we can therefore safely utilize statistical tools that use the mean to analyze our data, such as t-tests.
# 
# If the data are not symmetric, then the data are either left-skewed or right-skewed. 
# If the data are skewed, then the mean may not provide a good estimate for the center of the data and represent where most of the data fall. 
# In this case, you should consider using the median to evaluate the center of the data, rather than the mean.

# 2. The span of the data, where the min and max values lie

# 3. Outliers

ggsave("figures/plot - step 2.png", plot = chart.step2.histogram, height = 10, width = 15)



########################################################################
# 3. MEAN AND MEDIAN NUMBER OF STEPS TAKEN EACH DAY 
########################################################################

#  MEAN
print(mean(data.activity2$totalsteps,na.rm = TRUE))

#  MEDIAN
print(median(data.activity2$totalsteps,na.rm = TRUE))





########################################################################
# 4. TIME SERIES PLOT OF THE AVERAGE NUMBER OF STEPS TAKEN
########################################################################

chart.4.timeseries <-
  ggplot(data=data.activity2, aes(x=date,y=meanstepsperday))+
  geom_line()+
  ggtitle(label="Average steps per day")
plot(chart.4.timeseries)

ggsave("figures/plot - step 4.png", plot = chart.4.timeseries, height = 10, width = 15)
  
  


########################################################################
# 5. THE 5-MINUTE INTERVAL THAT ON AVERAGE CONTAINS THE MAX. # OF STEPS
########################################################################
# CREATE DATA TABLE SUMMARY
data.avg.steps <- 
  data.activity[!is.na(steps),
                .(
                  daily.mean.steps = mean(steps,na.rm = TRUE)
                ),
                by = c("interval")]

# SORT DATA BY VALUE DESCENDING ORDER
x <- data.avg.steps[order(-rank(daily.mean.steps))]
print(x[1,])





########################################################################
# 6. CODE TO DESCRIBE AND SHOW A STRATEGY FOR IMPUTING MISSING DATA 
########################################################################

#find the average for each interval
dim(data.avg.steps) # check to make sure there's an average for each interval (288)


# CREATE TABLE OF INTERVALS WITH MISSING DATA 
data.na <- data.activity[is.na(steps),2:3]
# APPLY THE INTERVAL AVERAGE TO THE MISSING DATA
data.na.imputed <- merge(data.na,data.avg.steps,by.x = 'interval',by.y = 'interval',all.x = FALSE)
# CHANGE COLUMN NAME
setnames(data.na.imputed,'daily.mean.steps','steps')
# CREATE DATA TABLE OF COMLETE OBSERVATIONS
data.activity.imputed <- data.activity[!is.na(steps)]
# REORDER COLUMNS
setcolorder(data.na.imputed,c("steps","date","interval"))
# RBIND 
data.imputed <- rbind(data.activity.imputed, data.na.imputed)
# CHECKS
dim(data.imputed) # should equal 17,568
anyNA(data.imputed) # should equal 'FALSE'






#########################################################################################
# 7. HISTOGRAM OF THE TOTAL No. OF STEPS TAKEN EACH DAY AFTER MISSING VALUES ARE IMPUTED 
#########################################################################################
# 
#  CREATE TABLE SUMMARISED BY DAY WITH IMPUTED DATA
data.imputed.summarised.byday <-
  data.imputed[,
               .(
                 totalsteps = sum(steps)
               ),
               by=c("date"
               )]

#  CHART TO SENSE CHECK THE DATA (VOLUME BY DAY)
chart.sense.check.imputed.data <-  
ggplot(data.imputed.summarised.byday)+
  aes(x=date,y=totalsteps)+
  stat_summary(fun.y = sum, geom = "bar")+
  ggtitle("The chart shows there are now no days with missing data",
          subtitle = "(data imputed using average steps per interval)")+
  scale_x_date(name = "Date")+
  scale_y_continuous(name = "Sum of steps by day")
plot(chart.sense.check.imputed.data)
  
    
#  HISTOGRAM WITH IMPUTED DATA FOR MISSING VALUES
chart.histogram.imputed <-
  ggplot(data.imputed.summarised.byday, aes(totalsteps))+
  geom_histogram(bins = 15, fill="green",alpha=3/4)+
  ggtitle(label="Histogram with imputed data", 
          subtitle = "The code to impute missing data appears to have
          worked, as the frequency around the center of the data has increased")+
  scale_x_continuous(name = "Total number of steps taken each day",labels = scales::comma)+  
  scale_y_continuous(name = "Frequency",breaks = seq(0,24, by = 2),limits = c(0,24))
plot(chart.histogram.imputed)

#  HISTOGRAM OF DATA EXCLUDING MISSING DATA
chart.histogram.excluding.missingvalues <-
  ggplot(data.activity2, aes(totalsteps))+
  geom_histogram(bins = 15, fill="green",alpha=1/2)+
  ggtitle(label="Histogram with dates with missing data excluded", 
          subtitle = "")+
  scale_x_continuous(name = "Total number of steps taken each day",labels = scales::comma)+  
  scale_y_continuous(name = "Frequency",breaks = seq(0,24, by = 2),limits = c(0,24))

grid.arrange(chart.histogram.excluding.missingvalues,chart.histogram.imputed,ncol=2)

#  PRINT 
chart.7 <- arrangeGrob(chart.histogram.excluding.missingvalues,chart.histogram.imputed,ncol=2)
ggsave("figures/plot - step 7.png", plot = chart.7, height = 10, width = 20)




############################################################################################################
# 8. PANEL PLOT COMPARING THE AVERAGE NUMBER OF STEPS TAKEN PER 5 MIN. INTERVAL ACROSS WEEKDAYS AND WEEKENDS 
############################################################################################################
head(data.imputed)
# CREATE VARIABLE DAY OF WEEK
data.imputed$dayofweek <- as.factor(wday(data.imputed$date, label=TRUE))
# CREATE VARIABLE WEEKDAY OR WEEKEND
data.imputed$weekday <- as.factor(ifelse(wday(data.imputed$date)==1,6,wday(data.imputed$date)-2))
data.imputed$daytype <- as.factor(ifelse(data.imputed$weekday %in% c(5,6),"Weekend","Weekday"))


# CREATE DATA TABLE WITH IMPUTED DATA
data.summarised.daytype <- 
  data.imputed[steps!='NA',
                .(
                  mean.steps = mean(steps,na.rm = TRUE),
                  total.steps = sum(steps,na.rm = TRUE)
                ),
                by = c("daytype",
                       "interval")]


# CREATE CHART
chart.8.daytype <-
  ggplot(data=data.summarised.daytype,aes(x=interval,y=mean.steps))+
  geom_line(aes(group=daytype,
                size=2,
                color=daytype,
                alpha=0.5))+
  scale_y_continuous(name="Mean steps")+
  scale_x_continuous(name="Time Interval (5 mins)")+
  ggtitle("On week days, the avg. number of steps are higher at the beginning of the day")+
  guides(alpha=FALSE,size=FALSE)

ggsave("figures/plot - step 8.png", plot = chart.8.daytype, height = 10, width = 15)



# R VERSION INFORMATION
writeLines(capture.output(sessionInfo()), "sessionInfo.txt") # Save R version details

#########################################################################################
# END OF SCRIPT 
#########################################################################################

 
# CLEAR MEMORY
rm(list = ls()) # If you want to delete all the objects in the workspace and start with a clean slate
gc() # Force R to release memory it is no longer using
rmarkdown::render("PA1_template.Rmd", clean = FALSE) #code to retain .md file


