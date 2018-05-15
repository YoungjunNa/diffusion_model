df <- read.csv("merge.txt")
df1 <- group_by(merge, group) %>% summarize(out=mean(고상.분뇨),처리=mean(고상.처리))

(sum(df1$out) - sum(df1$처리))/365/100
