# map load
pacman::p_load("rgdal","ggmap","plyr","dplyr","ggplot2","maps")

sig_shp <- readOGR("/Users/youngjunna/Github/diffusion_model/R","전국_법정구역정보(시군구)_201510")
sig_shp <- readOGR("/Users/youngjun/Github/diffusion_model/R","전국_법정구역정보(시군구)_201510")

sig_shp@data$id <- rownames(sig_shp@data) #idx 부여 
sig_shp_fortify <- fortify(sig_shp,by="id") #fortify함수 region =  id로
sig_shp_fortify_join <- join(sig_shp_fortify,sig_shp@data, by="id") #id로 조인!

# 
sig_shp_fortify_join %>% head(20)
df <- sig_shp_fortify_join %>% group_by(id,A2,A1) %>% summarise(n=n())
colnames(df)[2] <- "시군"
str(df)

ggplot(sig_shp_fortify_join, aes(long,lat,group=group)) + geom_polygon(fill="white",colour="black")
ggplot(sig_shp_fortify_join, aes(long,lat,group=group)) + geom_path() + coord_map("mercator")



# test
states_map <- map_data("state")

# 시각화
farm <- read.csv("merge.txt")
farm <- merge(farm, df, by="id")
colnames(farm)[6] <- "code"

theme_set(theme_gray(base_family="NanumGothic"))

ggplot(farm,aes(map_id=code,fill=output))+
  geom_map(map=sig_shp_fortify,colour="black",size=0.1)+
  expand_limits(x=sig_shp_fortify_join$long,y=sig_shp_fortify_join$lat)+
  scale_fill_gradientn(colours=c('white','orange','red'))+
  ggtitle("2016 고상가축분뇨 발생량")+
  coord_map()

library(kormaps2014)
map <- kormap2
