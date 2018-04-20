pacman::p_load("ggmap","dplyr","ggplot2","maps")
farm <- read.csv("geomap.txt",stringsAsFactors = FALSE)


korea <- enc2utf8("South Korea") %>%
  geocode() %>%
  as.numeric() %>%
  get_googlemap(maptype="roadmap",zoom=7) %>%
  ggmap()

# 시각화
korea + stat_density_2d(farm,aes(lon,lat,fill=..area..,alpha=..area..),geom="raster",size=2,bins=30)


ggplot(farm, aes(lon,lat,group=group,fill=area)) + geom_polygon(colour="black") + coord_map("d")


ggplot(korea, aes(lon,lat,group=group,)) + geom_polygon()+geom_raster(aes(fill=area),hjust=0.5,vjust=0.5,interpolate = FALSE) + scale_fill_gradientn(colours = rev(rainbow(7)), na.value = NA) + theme_bw() + coord_fixed(1.3)


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

korea + geom_map(farm,aes(lon,lat,group=group,fill=area))

