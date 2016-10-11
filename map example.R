x <- c("ggmap", "rgdal", "rgeos", "maptools", "dplyr", "tidyr", "tmap")
lapply(x, library, character.only = TRUE) # load the required packages

mysadmin <- readOGR(dsn = "data", layer = "MYS_adm2")

head(lnd@data, n = 2)
mean(lnd$Partic_Per)
head(lnd@polygons[[1]]@Polygons[[1]]@coords, 3)
plot(lnd@polygons[[1]]@Polygons[[1]]@coords)
# /Users/sratne/Documents/Tableau Datasets/Data Science /MYS_adm_shp/R_GIS_data/MYS_adm_shp
# Select zones where sports participation is between 20 and 25%
sel <- lnd$Partic_Per > 20 & lnd$Partic_Per < 25
plot(lnd[sel, ]) # output not shown here
head(sel) # test output of previous selection (not shown)
plot(lnd, col = "lightgrey") # plot the london_sport object
sel <- lnd$Partic_Per > 25
plot(lnd[ sel, ], col = "turquoise", add = TRUE) # add selected zones to map
EPSG <- make_EPSG() # create data frame of available EPSG codes
EPSG[grepl("WGS 84$", EPSG$note), ] # search for WGS 84 code
lnd84 <- spTransform(lnd, CRS("+init=epsg:4326")) # reproject
# Save lnd84 object (we will use it in Part IV)
saveRDS(object = lnd84, file = "data/lnd84.Rds")
# Create and look at new crime_data object
crime_data <- read.csv("data/mps-recordedcrime-borough.csv",stringsAsFactors = FALSE)
head(crime_data, 3) # display first 3 lines
head(crime_data$CrimeType) # information about crime type
# Extract "Theft & Handling" crimes and save
crime_theft <- crime_data[crime_data$CrimeType == "Theft & Handling", ]
head(crime_theft, 2) # take a look at the result (replace 2 with 10 to see more rows)
# Calculate the sum of the crime count for each district, save result
crime_ag <- aggregate(CrimeCount ~ Borough, FUN = sum, data = crime_theft)
# Show the first two rows of the aggregated crime data
head(crime_ag, 2)
# Compare the name column in lnd to Borough column in crime_ag to see which rows match.
lnd$name %in% crime_ag$Borough

mal_filepath = "/Users/sratne/Documents/Tableau Datasets/Data Science /MYS_adm_shp/R_GIS_data/MYS_adm_shp"
head(mys@data, n = 2)
# mean(mys$Partic_Per)
head(mys@polygons[[1]]@Polygons[[1]]@coords, 3)
plot(mys@polygons[[1]]@Polygons[[1]]@coords)

map.selangor <- subset(mysadmin, mysadmin$NAME_1 == "Selangor")
data.sel <- stars_master_data[stars_master_data$State == "SEL",]
g <- ggplot() +  geom_polygon(data=map.selangor, aes(x=long, y=lat, group=group))
g <- g +  geom_point(data=data.sel, aes(x=lon, y=lat), color="red")
g

# class(data.sel)
# ## [1] "data.frame"
# coordinates(data.sel)<-~lon+lat
# class(data.sel)
# ## [1] "SpatialPointsDataFrame"
# ## attr(,"package")
# ## [1] "sp"
# 
# # does it have a projection/coordinate system assigned?
# proj4string(data.sel) # nope
# ## [1] NA
# 
# # we know that the coordinate system is NAD83 so we can manually
# # tell R what the coordinate system is
# proj4string(data.sel)<-CRS("+proj=longlat +datum=NAD83")
# 
# # now we can use the spTransform function to project. We will project
# # the mapdata and for coordinate reference system (CRS) we will
# # assign the projection from counties
# 
# mapdata<-spTransform(data.sel, CRS(proj4string(map.selangor)))
# 
# # double check that they match
# identical(proj4string(data.sel),proj4string(map.selangor))
# ## [1] TRUE
names(data.sel)[names(data.sel)=="lon"]<-"x"
names(data.sel)[names(data.sel)=="lat"]<-"y"
ggplot() +geom_polygon(data=map.selangor, aes(x=long, y=lat, group=group))+  geom_point(data=data.sel, aes(x=x, y=y), color="red")
