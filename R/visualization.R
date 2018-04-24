pacman::p_load("ggmap","dplyr","ggplot2","maps","kormaps2014")
farm <- read.csv("geomap.txt",stringsAsFactors = FALSE,fileEncoding = "EUC-KR")

korea <- enc2utf8("South Korea") %>%
  geocode() %>%
  as.numeric() %>%
  get_googlemap(maptype="roadmap",zoom=7) %>%
  ggmap()

# 시각화
theme_set(theme_gray(base_family="NanumGothic"))

ggplot(korpop3,aes(map_id=code,fill=주택_계_호))+
  geom_map(map=kormap3,colour="black",size=0.1)+
  expand_limits(x=kormap3$long,y=kormap3$lat)+
  scale_fill_gradientn(colours=c('white','orange','red'))+
  ggtitle("2015년도 시도별 인구분포도")+
  coord_map()

map1 <- korpop1
map <- korpop2

korea + stat_density_2d(farm,aes(lon,lat,fill=..area..,alpha=..area..),geom="raster",size=2,bins=30)

ggplot(farm,aes(lon,lat))+geom_raster(aes(fill=area),hjust=0.5,vjust=0.5,interpolate=FALSE)

ggplot(farm, aes(lon,lat,group=group,fill=area)) + geom_polygon(colour="black") + coord_map("d")

ggplot(korea, aes(lon,lat,group=group,)) + geom_polygon()+geom_raster(aes(fill=area),hjust=0.5,vjust=0.5,interpolate = FALSE) + scale_fill_gradientn(colours = rev(rainbow(7)), na.value = NA) + theme_bw() + coord_fixed(1.3)


seals$z <- with(seals, sqrt(delta_long^2+delta_lat^2))
ggplot(seals,aes(long,lat))+geom_raster(aes(fill=z),hjust=0.5,vjust=0.5,interpolate = FALSE)
ggplot(seals,aes(long,lat))+geom_tile(aes(fill=z))


# manure data ####
manure <- read.csv("manure.csv",fileEncoding = "EUC-KR")
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

