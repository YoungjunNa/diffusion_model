pacman::p_load("ggmap","dplyr","ggplot2","maps","kormaps2014","plotly")
farm <- read.csv("geomap.txt",stringsAsFactors = FALSE)

# 시각화
theme_set(theme_gray(base_family="NanumGothic"))

ggplot(farm,aes(map_id=code,fill=output))+
  geom_map(map=kormap2,colour="black",size=0.1)+
  expand_limits(x=kormap2$long,y=kormap2$lat)+
  scale_fill_gradientn(colours=c('white','orange','red'))+
  ggtitle("2016 고상가축분뇨 발생량")+
  coord_map()

ggplot(farm,aes(map_id=code,fill=treated))+
  geom_map(map=kormap2,colour="black",size=0.1)+
  expand_limits(x=kormap2$long,y=kormap2$lat)+
  scale_fill_gradientn(colours=c('white','blue'))+
  ggtitle("2016 고상가축분뇨 처리량")+
  coord_map()

ggplot(farm,aes(map_id=code,fill=diff))+
  geom_map(map=kormap2,colour="black",size=0.1)+
  expand_limits(x=kormap2$long,y=kormap2$lat)+
  scale_fill_gradientn(colours=c('blue','white','red'))+
  ggtitle("2016 고상가축분뇨 발생량-처리량")+
  coord_map()

farm$output <- farm$output %>% round(0)
farm$diff <- farm$diff %>% round(0)
DT::datatable(farm)
