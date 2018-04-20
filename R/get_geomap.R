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

result <- group_by(farm,시군구) %>% summarise(area=sum(규모))
result$lon <- NA
result$lat <- NA


for(i in 1:(nrow(result))){
  result$lon[i] <- lon(result$시군구[i])
  result$lat[i] <- lat(result$시군구[i])
  i+1
}


write.csv(result, "geomap.txt",row.names=FALSE)
