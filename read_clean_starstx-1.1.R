library(data.table)
library(tidyr)


stars7_master_raw <- read.csv("latest master data 11Oct2016.csv",stringsAsFactors = F)
#stars7_master_retail <- read.csv("PRD_Stock Level and Sales(Retail).csv",stringsAsFactors = F)
stars7_master <- stars7_master_raw[,c(2,1,3,4,5,6,7,8,9,13,14,15,16,18,19,20)]
cnames <- c("Station_ID","Address_1","Address_2","City","Postcode","State","District","Region","Country")
cnames <- c(cnames,"Accessibilty","Binary_String","Actual_Max_Size","Latitude_Longitude")
cnames <- c(cnames,"User_Min_Stock","User_Max_Stock","Status")
names(stars7_master) <- cnames
#stars7_master <- stars7_master[cnames]
# stars7_master <- data.table(stars7_master)
# cnames <- c("Jalan","City","Postcode","State","District","Region")
# cnames <- c(cnames,"Accessibilty_Roadtanker","Binary_Opening_Weekdays","Latitude_Longitude")
# cnames <- c(cnames,"User_Min_Stock","User_Max_Stock","Opening_Time","Default_Terminal","Customer_Type","Closing_Time")
# names(stars_master_data) <- cnames
stars7_master$Latitude_Longitude <- as.character(stars7_master$Latitude_Longitude)
lonlat <- substr(stars7_master$Latitude_Longitude,2,nchar(stars7_master$Latitude_Longitude)-1)
pos_comma <- regexpr(',',lonlat)
# lat <- as.numeric(substr(lonlat,1,pos_comma-1))
lat <- substr(lonlat,1,pos_comma-1)

#lon <- as.numeric(substr(lonlat,pos_comma +1,nchar(lonlat)-1))
lon <- substr(lonlat,pos_comma +1,nchar(lonlat)-1)
stars7_master$latitude <- lat
stars7_master$longitude <- lon

rm(cnames,lat,lon,lonlat,pos_comma,stars7_master_raw)

stars7_master$Station_ID <- as.character(stars7_master$Station_ID)
stars7_master$Postcode <- as.character(stars7_master$Postcode)
#stars7_master_raw$Sold.to.ID <- as.character(stars7_master_raw$Sold.to.ID)
#stars7_master_raw$ShipTo.ID <- as.character(stars7_master_raw$ShipTo.ID)



#rm(stars7_master_raw)
# Transaction Data of 7 days stock and sales
stars_7_days_dt <- read.csv("data/PRD_Stock Level and Sales-14-10-2016.csv",stringsAsFactors = F)
cnames <- c("Day_1","Day_2","Day_3","Day_4","Day_5","Day_6","Day_7","Station_Name","Station_ID","Station_Region","Diesel_Quota","Tank_ID","Product_Name","Day_1_Sales","Day_2_Sales","Day_3_Sales","Day_4_Sales","Day_5_Sales","Day_6_Sales","Day_7_Sales","Day_1_Stock","Day_2_Stock","Day_3_Stock","Day_4_Stock","Day_5_Stock","Day_6_Stock","Day_7_Stock")
names(stars_7_days_dt) <- cnames
#date_range <- stars_7_days_dt[1,1:7]
date_range <- as.character(unlist(unname(stars_7_days_dt[1,1:7])))
cnames <- c(paste(date_range[1],"Sales",sep = "_"),
            paste(date_range[2],"Sales",sep = "_"),
            paste(date_range[3],"Sales",sep = "_"),
            paste(date_range[4],"Sales",sep = "_"),
            paste(date_range[5],"Sales",sep = "_"),
            paste(date_range[6],"Sales",sep = "_"),
            paste(date_range[7],"Sales",sep = "_"),
            paste(date_range[1],"Stock",sep = "_"),
            paste(date_range[2],"Stock",sep = "_"),
            paste(date_range[3],"Stock",sep = "_"),
            paste(date_range[4],"Stock",sep = "_"),
            paste(date_range[5],"Stock",sep = "_"),
            paste(date_range[6],"Stock",sep = "_"),
            paste(date_range[7],"Stock",sep = "_"))
cnames <- c("Day_1","Day_2","Day_3","Day_4","Day_5","Day_6","Day_7","Station_Name","Station_ID","Station_Region","Diesel_Quota","Tank_ID","Product_Name",cnames)
names(stars_7_days_dt) <- cnames
stars_7_days_dt$Start_Date_data <- stars_7_days_dt$Day_1
stars_7_days_dt$End_Date_data <- stars_7_days_dt$Day_7
#txdata <- txdata[-c("Day_1","Day_2","Day_3","Day_4","Day_5","Day_6","Day_7")]

stars_7_days_dt <- stars_7_days_dt[,-(1:7),drop=FALSE]
rm(cnames,date_range)
stars_7_days_dt$Station_ID <- as.character(stars_7_days_dt$Station_ID)
#stars_7_days_dt <- data.table(stars_7_days_dt)
#write.csv(stars_7_days_dt[,c(2,1,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20)],file = "data/stars_tx_reordered.csv")
#stars_7_days_dt <- read.csv("data/stars_tx_reordered.csv")
#stars7 <- stars_7_days_dt[,c(2,1,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20)]

