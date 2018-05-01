# 확산모델 시각화
pacman::p_load("ggplot2","dplyr")
farm <- read.csv("merge.txt")

# farm <- mutate(farm, hanwoo.manure=한우*13.7)
test1 <- filter(farm, A2=="광양시"|A2=="순천시"|A2=="여수시")
ggplot(test1, aes(long,lat,group=group)) + geom_path()

p <- ggplot(test1, aes(x=long, y=lat, group=group, fill=한우)) + geom_polygon(colour="black") + coord_map()
p <- ggplot(farm, aes(x=long,y=lat,group=group,fill=한우)) + geom_polygon() + scale_fill_gradientn(colours=c('white','orange','red')) + expand_limits(x=farm$long,y=farm$lat)+ ggtitle("한우두수") + labs(fill="한우 두수")

print(p)

p1 <- ggplot(farm, aes(x=long,y=lat,group=group,fill=합계.처리)) + geom_polygon() + expand_limits(x=farm$long,y=farm$lat)+ ggtitle("분뇨처리용량") + labs(fill="처리 용량")

print(p1)

farm$output <- farm$output %>% round(0)
farm$diff <- farm$diff %>% round(0)
DT::datatable(farm)
