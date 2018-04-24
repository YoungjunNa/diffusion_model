pacman::p_load("ggmap","dplyr","kormaps2014","sp","maptools")
register_google(key = "your API key from https://developers.google.com/maps/documentation/geocoding/get-api-key")

# sph file read
shape <- readOGR(dsn = "sig_shp_all")
shape <- read_sf(dsn = ".", layer = "sig_shp_all")
shape <- shapefile("sig_shp_all")
shape <- readShapePoly("sig_shp.shp")

# farm data ####
farm <- read.csv("farmdata.txt",stringsAsFactors = FALSE,fileEncoding = "EUC-KR")
farm <- filter(farm, 영업상태=="정상")
farm <- filter(farm, 축종=="한우" | 축종=="젖소" | 축종=="육우")
result <- group_by(farm,시군구) %>% summarise(area=sum(규모))

# map1 <- korpop1
map2 <- korpop2
# map3 <- korpop3

result$시군구





# 위도경도 function ####
lon <- function(name){
  map <- enc2utf8(name) %>%
    geocode()
  print(map$lon)
}

lat <- function(name){
  map <- enc2utf8(name) %>%
    geocode()
  print(map$lat)
}

result$lon <- NA
result$lat <- NA


for(i in 1:(nrow(result))){
  result$lon[i] <- lon(result$시군구[i])
  result$lat[i] <- lat(result$시군구[i])
  i+1
}


write.csv(result, "geomap.txt",row.names=FALSE)
