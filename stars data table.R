library(data.table)
stars_7_days_dt <- data.table(stars_7_days_dt)
setkey(stars_7_days_dt,Station_ID)


stars_master_dt <- data.table(stars7_master)
#stars_master_dt$Station_ID <- as.integer(stars_master_dt$Station_ID)
setkey(stars_master_dt,Station_ID)

stars7_master_retail_dt <- data.table(stars7_master_retail)
setkey(stars7_master_retail_dt,Station_ID)
#Change State Name to standard
#merge data

res <- stars_7_days_dt[stars7_master_retail_dt,nomatch=0]
sales_state <- res[Collection_Type == "Sales",sum(Sales_Stock_Count), by=.(State,Product_Name)]
# rm(stars7_master,stars_gather,stars_sep,stars7_master_raw,stars_7_days_dt,stars)
# rm(cnames,date_range,lat,lon,lonlat,pos_comma)

stars_master_dt$State[stars_master_dt$State == "PER"] <- "Perak"
stars_master_dt$State[stars_master_dt$State == "PAH"] <- "Pahang"
stars_master_dt$State[stars_master_dt$State == "SER"] <- "N. Sembilan"
stars_master_dt$State[stars_master_dt$State == "KED"] <- "Kedah"
stars_master_dt$State[stars_master_dt$State == "TRE"] <- "Terengganu"
stars_master_dt$State[stars_master_dt$State == "SEL"] <- "Selangor"
stars_master_dt$State[stars_master_dt$State == "MEL"] <- "Melaka"
stars_master_dt$State[stars_master_dt$State == "JOH"] <- "Johor"
stars_master_dt$State[stars_master_dt$State == "PSK"] <- "W. Persekutuan"
stars_master_dt$State[stars_master_dt$State == "PIN"] <- "P. Pinang"
stars_master_dt$State[stars_master_dt$State == "KEL"] <- "Kelantan"
stars_master_dt$State[stars_master_dt$State == "SAR"] <- "Sarawak"
stars_master_dt$State[stars_master_dt$State == "SAB"] <- "Sabah"
stars_master_dt$State[stars_master_dt$State == "PEL"] <- "Perlis"

#stars_dt[Collection_Type == "Sales",mean(Sales_Stock_Count), by Station_Region]
sales_region_mean <- stars_7_days_dt[Collection_Type == "Sales",mean(Sales_Stock_Count),by = Station_Region]
sales_region_sum <- stars_7_days_dt[Collection_Type == "Sales",sum(Sales_Stock_Count),by = Station_Region]

rm(stars7_master)
