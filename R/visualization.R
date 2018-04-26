pacman::p_load("ggmap","dplyr","ggplot2","maps","kormaps2014","plotly")
farm <- read.csv("geomap.txt",stringsAsFactors = FALSE)

# 시각화
theme_set(theme_gray(base_family="NanumGothic"))

ggplot(farm,aes(map_id=code,fill=animal))+
  geom_map(map=kormap2,colour="black",size=0.1)+
  expand_limits(x=kormap2$long,y=kormap2$lat)+
  scale_fill_gradientn(colours=c('white','orange','red'))+
  ggtitle("2016 대가축 분포")+
  coord_map()

ggplot(merge,aes(map_id=code,fill=animal))+
  geom_map(map=kormap3,colour="black",size=0.1)+
  expand_limits(x=kormap3$long,y=kormap3$lat)+
  scale_fill_gradientn(colours=c('white','orange','red'))+
  ggtitle("2016 대가축 분포")+
  coord_map()

ggplot(merge,aes(map_id=code,fill=manure))+
  geom_map(map=kormap2,colour="black",size=0.1)+
  expand_limits(x=kormap2$long,y=kormap2$lat)+
  scale_fill_gradientn(colours=c('white','blue'))+
  ggtitle("2016 분뇨 처리량")+
  coord_map()
