x <- c("ggmap", "rgdal", "rgeos", "maptools", "dplyr", "tidyr", "tmap","googleVis","ggplot2","data.table","raster","sp","shapefiles","rworldmap")
lapply(x, library, character.only = TRUE) # load the required packages
x <- CRS("+proj=longlat +ellps=WGS84")
mys <- readShapePoly("data/MYS_adm1",verbose = T,proj4string = x)
extent(mys)
head(mys@data)
wn <- getMap(resolution = "coarse")
plot(wn)
data("wrld_simpl",package = "maptools")
plot(wrld_simpl,add = T)

plot(mys,add=T,axes=T,border="red")
selangor <- subset(mys, mys$NAME_1=="Selangor")
plot(selangor,add=T,col="blue")
#mysadmin <- readOGR(dsn = "data", layer = "MYS_adm2")


#mal_filepath = "/Users/sratne/Documents/Tableau Datasets/Data Science /MYS_adm_shp/R_GIS_data/MYS_adm_shp"
#$head(mys@data, n = 2)
# mean(mys$Partic_Per)
#head(mys@polygons[[1]]@Polygons[[1]]@coords, 3)
#plot(mys@polygons[[1]]@Polygons[[1]]@coords)

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
