stars <- stars_7_days_dt[,c(1,2,3,4,5,6,7:20)]
#stars <- stars_7_days_dt
stars_gather <- gather(stars, Date_Count, Sales_Stock_Count, -c(1:6),na.rm = T)
stars_sep <- separate(stars_gather,Date_Count,c("Data_Collection_Date","Collection_Type"),sep = "_")

stars_sep$Data_Collection_Date <- as.Date(stars_sep$Data_Collection_Date,"%d/%m/%Y")
#stars_sep$Month <- 