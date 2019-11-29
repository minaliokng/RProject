library(RSelenium)

remDr <- remoteDriver(
  remoteServerAddr = "localhost",
  port = 4446L,
  browserName = "chrome"
)

html="https://assetstore.unity.com/?category=essentials&orderBy=1&page="
page=2

remDr$open()

Tname=c()
Tpub=c()
Tprc=c()

for(i in 0:page){
  Aname=c()
  Apub=c()
  Aprc=c()
  
  url=paste(html, i) #페이지 지정하고
  remDr$navigate(url) #해당 페이지 오픈
  
  Alist <- remDr$findElements(using = "css selector", "div.wWQpa") #이름 목록 찾아서
  Aname <- unlist(lapply(Alist, function(x) {x$getElementText()})) #unlist
  if(Aname[1]=="") Aname=Aname[2:length(Aname)]
  
  Alist <- remDr$findElements(using = "css selector", "a._1-e15._2vzs_") #회사명 찾음
  Apub <- unlist(lapply(Alist, function(x) {x$getElementText()})) #unlist
  
  Alist <- remDr$findElements(using = "css selector", "div.mErEH._223RA") #가격 찾음
  Aprc <- unlist(lapply(Alist, function(x) {x$getElementText()})) #unlist
  
  Tname=c(Tname, Aname)
  Tpub=c(Tpub, Apub)
  Tprc=c(Tprc, Aprc)
}

remDr$close() 

cbind(Tname, Tpub, Tprc)