library(data.table)

stars_master_data <- read.csv("latest master data 11Oct2016.csv",stringsAsFactors = F)
cnames <- c("Street","Bandar","Postcode","State","District","Region..North..South..East.or.Central.")
cnames <- c(cnames,"Accessibilty.Roadtanker","Binary.opening.weekdays.string","Latitude.Longitude..Road")
cnames <- c(cnames,"User.Min.Stock","User.Max.Stock","Opening.time","Default.terminal","Customer.type","Closing.time")
stars_master_data <- stars_master_data[cnames]
stars_master_data <- data.table(stars_master_data)
cnames <- c("Jalan","City","Postcode","State","District","Region")
cnames <- c(cnames,"Accessibilty_Roadtanker","Binary_Opening_Weekdays","Latitude_Longitude")
cnames <- c(cnames,"User_Min_Stock","User_Max_Stock","Opening_Time","Default_Terminal","Customer_Type","Closing_Time")
names(stars_master_data) <- cnames
stars_master_data$Latitude_Longitude <- as.character(stars_master_data$Latitude_Longitude)
lonlat <- substr(stars_master_data$Latitude_Longitude,2,nchar(stars_master_data$Latitude_Longitude)-1)
pos_comma <- regexpr(',',lonlat)
lat <- as.numeric(substr(lonlat,1,pos_comma-1))
#lat <- substr(lonlat,nchar(lonlat)-1)
lon <- as.numeric(substr(lonlat,pos_comma +1,nchar(lonlat)-1))
stars_master_data$lat <- lat
stars_master_data$lon <- lon
stars_7_days_dt <- read.csv("stock level.csv")
cnames <- c("Day_1","Day_2","Day_3","Day_4","Day_5","Day_6","Day_7","Station_Name","Station ID","Station_Region","Diesel_Quota","Tank_ID","Product_Name","Day_1_Sales","Day_1_Stock","Day_2_Sales","Day_2_Stock","Day_3_Sales","Day_3_Stock","Day_4_Sales","Day_4_Stock","Day_5_Sales","Day_5_Stock","Day_6_Sales","Day_6_Stock","Day_7_Sales","Day_7_Stock")
names(stars_7_days_dt) <- cnames
date_range <- stars_7_days_dt[1,1:7]
cnames <- c(paste(date_range[1,1],"sales",sep = "_"),
            paste(date_range[1,1],"stock",sep = "_"),
            paste(date_range[1,2],"sales",sep = "_"),
            paste(date_range[1,2],"stock",sep = "_"),
            paste(date_range[1,3],"sales",sep = "_"),
            paste(date_range[1,3],"stock",sep = "_"),
            paste(date_range[1,4],"sales",sep = "_"),
            paste(date_range[1,4],"stock",sep = "_"),
            paste(date_range[1,5],"sales",sep = "_"),
            paste(date_range[1,5],"stock",sep = "_"),
            paste(date_range[1,6],"sales",sep = "_"),
            paste(date_range[1,6],"stock",sep = "_"),
            paste(date_range[1,7],"sales",sep = "_"),
            paste(date_range[1,7],"stock",sep = "_"))
cnames <- c("Day_1","Day_2","Day_3","Day_4","Day_5","Day_6","Day_7","Station_Name","Station ID","Station_Region","Diesel_Quota","Tank_ID","Product_Name",cnames)
names(stars_7_days_dt) <- cnames
#stars_7_days_dt$Start_Date_data <- stars_7_days_dt$Day_1
#stars_7_days_dt$End_Date_data <- stars_7_days_dt$Day_7
# txdata <- txdata[-c("Day_1","Day_2","Day_3","Day_4","Day_5","Day_6","Day_7")]

stars_7_days_dt <- stars_7_days_dt[,-(1:7),drop=FALSE]
stars_7_days_dt <- data.table(stars_7_days_dt)


