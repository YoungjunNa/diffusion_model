pacman::p_load("ggmap","dplyr","kormaps2014","sp","maptools","rgdal")
register_google(key = "your API key from https://developers.google.com/maps/documentation/geocoding/get-api-key")

# sph file read
shape <- readOGR(dsn = path.expand("/Users/youngjunna/Github/diffusion_model/R"),layer="sig_shp")
shape <- readOGR(dsn = path.expand("sig_shp.shp"), 
                 layer = "sig_shp")
library(raster)
shp <- shapefile("/Users/youngjunna/Github/diffusion_model/R/sig_shp_all.shp")

library(sf)
shp <- st_read(system.file("/Users/youngjunna/Github/diffusion_model/R/sig_shp_all.shp", package="sf"))

# shape <- read_sf(dsn = ".", layer = "sig_shp_all")
# shape <- shapefile("sig_shp_all")
shape <- readShapePoly("/Users/youngjunna/Github/diffusion_model/R/sig_shp")

file.choose()

# farm data ####
farm <- read.csv("farmdata.txt",stringsAsFactors = FALSE,fileEncoding = "EUC-KR")
farm <- filter(farm, 영업상태=="정상")
farm <- filter(farm, 축종=="한우" | 축종=="젖소" | 축종=="육우")
result <- group_by(farm,시군구) %>% summarise(area=sum(규모))

animal <- read.csv("animal-2016.txt",stringsAsFactors = FALSE)
ruminant <- filter(animal, 축종명=="한우"|축종명=="젖소"|축종명=="육우")
result <- group_by(ruminant,시군) %>% summarise(animal=sum(규모))
result$시군 <- as.factor(result$시군)

map2 <- korpop2

names(map2)[2] <- "시군"
test <- merge(map2, result,by="시군")
