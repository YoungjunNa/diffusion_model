pacman::p_load("ggmap","tidyverse")

# farm data ####
farm <- read.csv("farmdata.csv",stringsAsFactors = FALSE)
farm <- filter(farm, 영업상태=="정상")

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

# 위도경도 function

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


result <- group_by(farm,시군구) %>% summarise(area=sum(규모))
result <- mutate(result,lon=lon(시군구))
result$lon <- NA

nrow(result)
lon(farm$시군구[1])

for(i in 0:nrow(result)){
  i+1
  result$lon[i] <- lon(result$시군구[i])
}


lon(result$시군구[1])
result[2,1]

lon("강원도 동해시")

# 시각화

ggplot(result, aes(x = long, y = lat, fill = degF)) + 
  geom_raster(interpolate = TRUE) +
  scale_fill_gradientn(colours = rev(rainbow(7)), na.value = NA) +
  theme_bw() +
  coord_fixed(1.3)


seals$z <- with(seals, sqrt(delta_long^2+delta_lat^2))
ggplot(seals,aes(long,lat))+geom_raster(aes(fill=z),hjust=0.5,vjust=0.5,interpolate = FALSE)
ggplot(seals,aes(long,lat))+geom_tile(aes(fill=z))


