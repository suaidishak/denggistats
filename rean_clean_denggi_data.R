library(ggplot2)
library(data.table)
# Read denggi data from 2012-2015
df.2012 <- read.csv('data/LokalitiHotspot2012.csv')
df.2013 <- read.csv('data/LokalitiHotspot2013.csv')
df.2014 <- read.csv('data/LokalitiHotspot2014.csv')
df.2015 <- read.csv('data/LokalitiHotspot2015.csv')
df <- rbind(df.2012, df.2013, df.2014, df.2015)
# rename column names
names(df)<-c('Year','Week','State','District','Location','Total_Cases','Outbreak_Duration')
# change char data to numeric
df$Total_Cases <- as.numeric(df$Total_Cases)
df$Outbreak_Duration <- as.numeric(df$Outbreak_Duration)
# change Year to factor
df$Year <- as.factor(df$Year)
# removing NA data of Total_Cases
df <- na.omit(df)
