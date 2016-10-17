library(data.table)
library(tidyr)



stars7_master_retail <- read.csv("PRD_Stock Level and Sales(Retail).csv",stringsAsFactors = F)
#stars7_master_retail <- stars7_master_retail[,c(2,1,3:62)]
# cnames <- c("ForeignID","Name","Default.terminal",
#             "Monthly.Diesel.Quota","Street",
#             "Bandar","State","District",                              
#         "Region..North..South..East.or.Central.","Email",
#         "Telephone","Accessibilty.Roadtanker",
#         "Next.Critical.Stock","Latitude.Longitude..Road",
#         "Status","Sold.to.Name","Sold.to.ID",                            "ShipTo.ID" ,                            
#         "Sales.Organisation.for.SAP.field" ,      "Postcode"    ,                          
#         "Position.Method..Road"             ,     "Position.Method..Home"      ,           
#         "POI"                                ,    "Planned.Trips"      ,                   
#         "Overridden.terminal.for.97"          ,   "Order.Type.2"     ,                     
#         "Order.Type.1"                       ,    "Opening.time"          ,                
#         "No.delivery.start.2"                ,    "No.delivery.start.1"  ,                 
#         "No.delivery.end.2"                  ,    "No.delivery.end.1"    ,                 
#         "Name2"                              ,    "Mobile"         ,                       
#         "Marked.for.export"                  ,    "Latitude.Longitude..Home"       ,       
#         "Last.Visit"                         ,    "Last.changed.by.user"  ,                
#         "Last.changed"                       ,    "Just.in.Time...1"    ,                  
#         "Just.in.Time"                       ,    "House.Suffix"     ,                     
#         "House.Number"                       ,    "GPS.validated"    ,                     
#         "Fax"                                 ,   "Division.for.SAP.field"   ,             
#         "Distribution.Channel.for.SAP.field"   ,  "CUSTOMERINFOTEXT23"  ,                  
#         "Customer.type"                 ,         "Customer.Group"  ,                      
#         "Created.by.user"                ,        "Created"     ,                          
#         "Country.Code"                    ,       "Country"     ,                          
#         "Coordinate..Road"                 ,      "Coordinate..Home"    ,                  
#         "Contact.Name"                      ,     "Consolidation.Group"   ,                
#         "Closing.time"                      ,     "Binary.opening.weekdays.string"   ,     
#         "Alternative.Street"                 ,    "Address.District" )                     
cnames <- c("Station_ID","Name","Default_Terminal",
            "Monthly_Diesel_Quota","Street",
            "City","State","District",                              
            "Region","Email",
            "Telephone","Accessibilty_Roadtanker",
            "Next.Critical.Stock","Latitude_Longitude",
            "Status","Sold.to.Name","Sold.to.ID",                            "ShipTo.ID" ,                            
            "Sales.Organisation.for.SAP.field" ,      "Postcode"    ,                          
            "Position.Method..Road"             ,     "Position.Method..Home"      ,           
            "POI"                                ,    "Planned.Trips"      ,                   
            "Overridden.terminal.for.97"          ,   "Order.Type.2"     ,                     
            "Order.Type.1"                       ,    "Opening.time"          ,                
            "No.delivery.start.2"                ,    "No.delivery.start.1"  ,                 
            "No.delivery.end.2"                  ,    "No.delivery.end.1"    ,                 
            "Name2"                              ,    "Mobile"         ,                       
            "Marked.for.export"                  ,    "Latitude.Longitude..Home"       ,       
            "Last.Visit"                         ,    "Last.changed.by.user"  ,                
            "Last.changed"                       ,    "Just.in.Time...1"    ,                  
            "Just.in.Time"                       ,    "House.Suffix"     ,                     
            "House.Number"                       ,    "GPS.validated"    ,                     
            "Fax"                                 ,   "Division.for.SAP.field"   ,             
            "Distribution.Channel.for.SAP.field"   ,  "CUSTOMERINFOTEXT23"  ,                  
            "Customer_Type"                 ,         "Customer_Group"  ,                      
            "Created.by.user"                ,        "Created"     ,                          
            "Country.Code"                    ,       "Country"     ,                          
            "Coordinate..Road"                 ,      "Coordinate..Home"    ,                  
            "Contact.Name"                      ,     "Consolidation.Group"   ,                
            "Closing.time"                      ,     "Binary.opening.weekdays.string"   ,     
            "Alternative.Street"                 ,    "Address.District" ) 
# cnames <- c("Station_ID","Address_1","Address_2","City","Postcode","State","District","Region","Country")
# cnames <- c(cnames,"Accessibilty","Binary_String","Actual_Max_Size","Latitude_Longitude")
# cnames <- c(cnames,"User_Min_Stock","User_Max_Stock","Status")
names(stars7_master_retail) <- cnames
#stars7_master <- stars7_master[cnames]
# stars7_master <- data.table(stars7_master)
# cnames <- c("Jalan","City","Postcode","State","District","Region")
# cnames <- c(cnames,"Accessibilty_Roadtanker","Binary_Opening_Weekdays","Latitude_Longitude")
# cnames <- c(cnames,"User_Min_Stock","User_Max_Stock","Opening_Time","Default_Terminal","Customer_Type","Closing_Time")
# names(stars_master_data) <- cnames
stars7_master_retail$Latitude_Longitude <- as.character(stars7_master_retail$Latitude_Longitude)
lonlat <- substr(stars7_master_retail$Latitude_Longitude,2,nchar(stars7_master_retail$Latitude_Longitude)-1)
pos_comma <- regexpr(',',lonlat)
# lat <- as.numeric(substr(lonlat,1,pos_comma-1))
lat <- substr(lonlat,1,pos_comma-1)

#lon <- as.numeric(substr(lonlat,pos_comma +1,nchar(lonlat)-1))
lon <- substr(lonlat,pos_comma +1,nchar(lonlat)-1)
stars7_master_retail$latitude <- lat
stars7_master_retail$longitude <- lon

rm(cnames,lat,lon,lonlat,pos_comma,stars7_master_raw)

stars7_master_retail$Station_ID <- as.character(stars7_master_retail$Station_ID)
stars7_master_retail$Postcode <- as.character(stars7_master_retail$Postcode)

stars7_master_retail$State[stars7_master_retail$State == "PER"] <- "Perak"
stars7_master_retail$State[stars7_master_retail$State == "PAH"] <- "Pahang"
stars7_master_retail$State[stars7_master_retail$State == "SER"] <- "N. Sembilan"
stars7_master_retail$State[stars7_master_retail$State == "KED"] <- "Kedah"
stars7_master_retail$State[stars7_master_retail$State == "TRE"] <- "Terengganu"
stars7_master_retail$State[stars7_master_retail$State == "SEL"] <- "Selangor"
stars7_master_retail$State[stars7_master_retail$State == "MEL"] <- "Melaka"
stars7_master_retail$State[stars7_master_retail$State == "JOH"] <- "Johor"
stars7_master_retail$State[stars7_master_retail$State == "PSK"] <- "W. Persekutuan"
stars7_master_retail$State[stars7_master_retail$State == "PIN"] <- "P. Pinang"
stars7_master_retail$State[stars7_master_retail$State == "KEL"] <- "Kelantan"
stars7_master_retail$State[stars7_master_retail$State == "SAR"] <- "Sarawak"
stars7_master_retail$State[stars7_master_retail$State == "SAB"] <- "Sabah"
stars7_master_retail$State[stars7_master_retail$State == "PEL"] <- "Perlis"

stars7_master_retail$City <-  sapply(stars7_master_retail$City, tolower)
stars7_master_retail$City <-  sapply(stars7_master_retail$City, simpleCap)
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

