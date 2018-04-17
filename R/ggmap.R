pacman::p_load("ggmap","dplyr")
register_google(key = "your API key from https://developers.google.com/maps/documentation/geocoding/get-api-key")

# farm data ####
farm <- read.csv("farmdata.txt",stringsAsFactors = FALSE)
farm <- filter(farm, 영업상태=="정상")

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

#
result <- group_by(farm,시군구) %>% summarise(area=sum(규모))
# result <- mutate(result,lon=lon(시군구))
result$lon <- NA
result$lat <- NA

nrow(result)
lon(farm$시군구[3])
lon("충청북도 충주시")

for(i in 1:(nrow(result)-1)){
  result$lon[i] <- lon(result$시군구[i])
  result$lat[i] <- lat(result$시군구[i])
  i+1
}

for(i in 189){
  result$lon[i] <- lon(result$시군구[i])
  result$lat[i] <- lat(result$시군구[i])
  i+1
}


write.csv(result, "geomap.txt",row.names=FALSE)


# 시각화

ggplot(result, aes(x = long, y = lat, fill = degF)) + 
  geom_raster(interpolate = TRUE) +
  scale_fill_gradientn(colours = rev(rainbow(7)), na.value = NA) +
  theme_bw() +
  coord_fixed(1.3)


seals$z <- with(seals, sqrt(delta_long^2+delta_lat^2))
ggplot(seals,aes(long,lat))+geom_raster(aes(fill=z),hjust=0.5,vjust=0.5,interpolate = FALSE)
ggplot(seals,aes(long,lat))+geom_tile(aes(fill=z))


# manure data ####
manure <- read.csv("manure.csv")
manure

seoul <- enc2utf8("대한민국") %>%
  geocode() %>%
  as.numeric() %>%
  get_googlemap(maptype="roadmap",zoom=12) %>%
  ggmap()

korea <- enc2utf8("South Korea") %>%
  geocode() %>%
  as.numeric() %>%
  get_googlemap(maptype="roadmap",zoom=7) %>%
  ggmap()
