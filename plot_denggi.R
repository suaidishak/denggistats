# plotting Denggi data

# Convert data to data.table

dt <- data.table(df)
# Group data by year

dt.by.year <- dt[, sum(df$Total_Cases), by = Year]
