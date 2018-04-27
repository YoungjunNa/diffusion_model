pacman::p_load("dplyr","kormaps2014")

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

# compare <- ruminant %>% group_by(시군,축종명) %>% summarise(output=sum(규모))
# result <- group_by(ruminant,시군) %>% summarise(animal=sum(규모))
# result <- group_by(animal, 시군) %>% summarise(animal=sum(규모))

ruminant$output <- NA
ruminant$output <- ifelse(ruminant$축종명=="한우"|ruminant$축종명=="육우",ruminant$규모*manure_out$hanwoo$output/1000*365,ruminant$규모*manure_out$holstein$output/1000*365)
result <- group_by(ruminant,시군) %>% summarise(output=sum(output))

map2 <- korpop2
names(map2)[2] <- "시군"
map2$시군 <- as.character(map2$시군)
map2$시군 <- gsub(" ","",map2$시군)

merge <- merge(map2,result,by="시군",all=TRUE)
# merge$animal[is.na(merge$animal)] <- 0
merge$output[is.na(merge$output)] <- 0


manure2 <- read.csv("manure2.txt")
manure2 <- filter(manure2,축종=="한육우"|축종=="젖소")
result2 <- manure2 %>% group_by(시군) %>% summarise(treated=sum(발생량))

merge <- merge(merge,result2,by="시군",all=TRUE)
merge$treated[is.na(merge$treated)] <- 0

#merge
merge <- merge[c("시군","code","output","treated")]
merge$unit <- "ton/year"
merge$diff <- merge$output-merge$treated



#write.csv
write.csv(merge,"geomap.txt",row.names = FALSE)










# # 읍면동 기준
# animal <- read.csv("animal-2016.txt",stringsAsFactors = FALSE)
# ruminant <- filter(animal, 축종명=="한우"|축종명=="젖소"|축종명=="육우")
# result <- group_by(ruminant,읍면동) %>% summarise(animal=sum(규모))
# 
# map3 <- korpop3
# names(map3)[2] <- "읍면동"
# map3$읍면동 <- gsub(" ","",map3$읍면동)
# 
# merge <- merge(map3,result,by="읍면동",all=TRUE)
# is.na(merge$animal) <- 0

# 가축분뇨 처리
# manure <- read.csv("manure.csv",fileEncoding = "EUC-KR")
# manure <- group_by(manure,행정.시군코드명) %>% summarise(manure=sum(가축원뇨수거.원뇨수거.톤.일.))
# # manure <- group_by(manure,행정.시군코드명) %>% summarise(manure=sum(가축원뇨수거.수거물량.통.))
# names(manure)[1] <- "시군"
# 
# map2 <- korpop2
# names(map2)[2] <- "시군"
# map2$시군 <- as.character(map2$시군)
# map2$시군 <- gsub(" ","",map2$시군)

# merge <- merge(map2,manure,by="시군",all=TRUE)

# merge$manure[merge$시군=="양산시"] <- 0
# merge$manure[merge$시군=="함안군"] <- 0
# merge$manure[merge$시군=="사천시"] <- 0

# manure2 <- readxl::read_excel("manure2.xlsx")
# 
# for(i in seq(1,nrow(manure2),5)){
#   manure2$시군[i+1] <- manure2$시군[i]
#   manure2$시군[i+2] <- manure2$시군[i]
#   manure2$시군[i+3] <- manure2$시군[i]
#   manure2$시군[i+4] <- manure2$시군[i]
# }
# 
# write.csv(manure2,"manure2.txt",row.names = FALSE)