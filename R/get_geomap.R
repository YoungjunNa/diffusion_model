pacman::p_load("dplyr","kormaps2014")
register_google(key = "your API key from https://developers.google.com/maps/documentation/geocoding/get-api-key")

# 가축분뇨 배출원단위(kg/두/일)
hanwoo <- data.frame(bw=350,feces=8,urine=5.7,total=13.7,output=13.7)
holstein <- data.frame(bw=450,feces=19.2,urine=10.9,total=30.1,output=37.7)
swine <- data.frame(bw=60,feces=0.87,urine=1.74,total=2.49,output=5.1)
layer <- data.frame(bw=1.7,feces=0.1247,urine=NA,total=0.1247,output=0.1247)
broiler <- data.frame(bw=1.3,feces=0.0855,urine=NA,total=0.0855,output=0.0855)

manure_out <- list(hanwoo=hanwoo,holstein=holstein,swine=swine,layer=layer,broiler=broiler)

# 시군기준
animal <- read.csv("animal-2016.txt",stringsAsFactors = FALSE)
ruminant <- filter(animal, 축종명=="한우"|축종명=="젖소"|축종명=="육우")
result <- group_by(ruminant,시군) %>% summarise(animal=sum(규모))
# result <- group_by(animal, 시군) %>% summarise(animal=sum(규모))

result$output <- NA
result$output <- ifelse(ruminant$축종명=="한우",ruminant$규모*manure_out$hanwoo$output)


map2 <- korpop2
names(map2)[2] <- "시군"
map2$시군 <- as.character(map2$시군)
map2$시군 <- gsub(" ","",map2$시군)

merge <- merge(map2,result,by="시군",all=TRUE)
merge$animal[is.na(merge$animal)] <- 0

write.csv(merge,"geomap.txt",row.names = FALSE)

# 읍면동 기준
animal <- read.csv("animal-2016.txt",stringsAsFactors = FALSE)
ruminant <- filter(animal, 축종명=="한우"|축종명=="젖소"|축종명=="육우")
result <- group_by(ruminant,읍면동) %>% summarise(animal=sum(규모))

map3 <- korpop3
names(map3)[2] <- "읍면동"
map3$읍면동 <- gsub(" ","",map3$읍면동)

merge <- merge(map3,result,by="읍면동",all=TRUE)
is.na(merge$animal) <- 0

# 가축분뇨 처리
manure <- read.csv("manure.csv",fileEncoding = "EUC-KR")
# manure <- group_by(manure,행정.시군코드명) %>% summarise(manure=sum(가축원뇨수거.원뇨수거.톤.일.))
manure <- group_by(manure,행정.시군코드명) %>% summarise(manure=sum(가축원뇨수거.수거물량.통.))
names(manure)[1] <- "시군"

map2 <- korpop2
names(map2)[2] <- "시군"
map2$시군 <- as.character(map2$시군)
map2$시군 <- gsub(" ","",map2$시군)

merge <- merge(map2,manure,by="시군",all=TRUE)
merge$manure[is.na(merge$manure)] <- 0
merge$manure[merge$시군=="양산시"] <- 0
merge$manure[merge$시군=="함안군"] <- 0
merge$manure[merge$시군=="사천시"] <- 0
