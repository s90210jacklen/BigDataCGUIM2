##從上次的解答開始
if (!require('SportsAnalytics')){
  install.packages("SportsAnalytics")
  library(SportsAnalytics)
}
NBA1415<-fetch_NBAPlayerStatistics("14-15")
for(i in 1:nrow(NBA1415)){
  if(NBA1415[i,"GamesPlayed"]>70&NBA1415[i,"TotalPoints"]>1500){
    print(NBA1415[i,c("Name","Team","Position")])
  }
}

## 都說了for不好用
subset(NBA1415,GamesPlayed>70&TotalPoints>1500)[,c("Name","Team","Position")]
## 都說了for不好用-2
NBA1415[NBA1415$GamesPlayed>70&NBA1415$TotalPoints>1500,c("Name","Team","Position")]

## 可是....還是有想用的時候啊....
San<-subset(NBA1415,Team=='SAN')
order(San$TotalPoints,decreasing = T)
San[order(San$TotalPoints,decreasing = T)[1],
    c("Name","Team","TotalPoints")]

##我們還是用for+unique()試試看好了
unique(NBA1415$Team)
for(team in unique(NBA1415$Team)){
  selectTeam<-subset(NBA1415,Team==team)
  print(selectTeam[order(selectTeam$TotalPoints,decreasing = T)[1],
                   c("Name","Team","TotalPoints")])
}

##用rbind()把輸出整理成一個Data Frame
FinalOutput<-NULL
for(team in unique(NBA1415$Team)){
  selectTeam<-subset(NBA1415,Team==team)
  FinalOutput<-rbind(FinalOutput,
                     selectTeam[
                       order(selectTeam$TotalPoints,decreasing = T)[1],
                       c("Name","Team","TotalPoints")])
}
FinalOutput



##apply()
apply(NBA1415,2,max)
##apply()範例2
apply(NBA1415[,c("GamesPlayed","TotalMinutesPlayed","TotalPoints")],2,mean)


##sapply()
sapply(iris, mean)
##sapply()範例2
sapply(NBA1415[,c("GamesPlayed","TotalMinutesPlayed","TotalPoints")],mean)


##lapply(): List
lapply(iris, mean)

##lapply()範例2
lapply(NBA1415[,c("GamesPlayed","TotalMinutesPlayed","TotalPoints")],mean)


##tapply()
tapply(NBA1415$Name,NBA1415$Team,length)
tapply(NBA1415$TotalPoints,NBA1415$Team,max)
tapply(NBA1415$TotalPoints,NBA1415$Team,mean)
tapply(NBA1415$TotalPoints,NBA1415$Team,range)

##split()
split(1:30,gl(3, 10))

##split()+lapply()
lapply(split(1:30,gl(3, 10)),mean)
tapply(1:30,gl(3, 10),mean)


##Data Frame也可以split()
NBA1415Team<-split(NBA1415[,c("TotalPoints","GamesPlayed")],NBA1415$Team)
##split()搭配apply()家族使用
lapply(NBA1415Team, colMeans)
sapply(NBA1415Team, colMeans)

##split()：用多個欄位來分群
NBA1415TP<-split(NBA1415[,c("TotalPoints","GamesPlayed")],list(NBA1415$Team,NBA1415$Position))
lapply(NBA1415TP, colMeans)
sapply(NBA1415TP, colMeans)

##類似apply家族的函數：aggregate()
aggregate(NBA1415$TotalPoints, by=list(NBA1415$Team,NBA1415$Position), FUN=mean, na.rm=TRUE)
##類似apply家族的函數：aggregate()-2
aggregate(TotalPoints ~ Team+Position, data = NBA1415, mean)
aggregate(TotalRebounds ~ Team+Position, data = NBA1415, mean)
##TotalRebounds->籃板數
#Missing Value
x<-c(1,2,3,4,5,NA)
mean(x)
mean(x, na.rm=T)
sum(x)
sum(x, na.rm=T)

##Removing NA
x <- c(1, 2, NA, 4, NA, 5)
x[! is.na(x)]
x[! complete.cases(x)]


##定義一個新的函數
round2<-function(v){
  round(v,digits = 2)
}
round2(3.886)
##Lazy Evaluation
round2Lazy<-function(vector,nothing){
  round(vector,digits = 2)
}
round2(3.886)
##Lazy Evaluation 2
f <- function(a, b) {
  print(a)
  print(b)
}
f(45)
##…參數
roundmean<-function(vector, ...){
  round(mean(vector,...),digits=2)
}
roundmean(c(1.1,2,3,4,5))
roundmean(c(1.1,2,3,4,5,NA))
roundmean(c(1.1,2,3,4,5,NA),na.rm=T)

##參數預設值
roundDe<-function(v=1.111:10.111){
  round(v,digits = 2)
}
roundDe(1.66:6.66)
roundDe()
##retrun()
round2<-function(v){
  if(!is.numeric(v)){
    print("輸入數字")
    return()
  }
  round(v,digits = 2)
}
round2("a")


##函數也可以當作參數來用
apply(iris,2,max)

RoundNumber2<-function(v,XFun){
  round(XFun(v),digits = 2)
}
RoundNumber2(1.1:10.1,mean)

##從網路上下載檔案 download.file
if (!require('RCurl')){
  install.packages("RCurl")
  library(RCurl)
}
download.file("https://raw.githubusercontent.com/yijutseng/
              BigDataCGUIM/master/files/opendata10401.csv", 
              destfile = "open.csv", method = "curl")

## read.csv使用範例
data <- read.csv('open.csv')
data
