library(data.table)
library(ggplot2)
library(plotly)
df.2012 <- read.csv('LokalitiHotspot2012.csv')
df.2013 <- read.csv('LokalitiHotspot2013.csv')
df.2014 <- read.csv('LokalitiHotspot2014.csv')
df.2015 <- read.csv('LokalitiHotspot2015.csv')
df <- rbind(df.2012, df.2013, df.2014, df.2015)
dt <- as.data.table(df)
dt <- na.omit(dt)
names(dt)<-c('Year','Week','State','District','Location','Total_Cases','Outbreak_Duration')
dt.year.month <- as.Date(paste("1",dt$Week, as.numeric(dt$Year),sep = "-"), format = "%w-%W-%Y") # get week of the year
dt$WeekDate <- dt.year.month
dt$Year <- as.factor(dt$Year)
dt$Total_Cases <- as.numeric(dt$Total_Cases)
dt[grepl("inang",State), State := "P. Pinang"]
dt[grepl("elangor",State), State := "Selangor"]
dt[grepl("Pera",State), State := "Perak"]
dt[grepl("WPKL",State), State := "Wilayah Persekutuan"]

dtdengue <- dt[,sum(Total_Cases),by = list(Year,State)]
names(dtdengue) <- c("Year","State","Total_Cases")
dtdengueYear <- dt[,sum(Total_Cases),by = Year]
dtdengueState <- dt[,sum(Total_Cases),by = State]
names(dtdengueYear) <- c("Year","Total_Cases")
names(dtdengueState) <- c("State","Total_Cases")
dtdengueDistrict <- dt[,sum(Total_Cases),by = list(Year,State,District)]
names(dtdengueDistrict) <- c("Year","State","District","Total_Cases")
plot_ly(data = dtdengue,x = ~Year, y = ~log(Total_Cases),type = "scatter",mode = "lines", color = ~State)

ggplot(dtdengue, aes(x=factor(Year), y=log(Total_Cases), fill=State)) + geom_bar(stat="identity",position="dodge") +labs(title="Comparison of states", x="Year",y="Total", fill="State") + theme_bw()

ggplot(data = dt ,aes(WeekDate, Total_Cases)) + geom_line() 
scale_x_date(format = "%b-%Y") + xlab("") + ylab("Daily Views")
mysadmin <- readOGR(dsn = "data", layer = "MYS_adm2")
selangor <- subset(mysadmin, mysadmin$NAME_1 == "Selangor")
