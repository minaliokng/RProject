library(rvest)

url='http://www.hotelskorea.or.kr/plaza/index_4.php?grade=&sido=&gugun=&keyword=&page='

page=1:21

# each page URL
pages=paste0(url, page, sep='')

# extract data from page url

extract = function(page_url) {
  # 웹 사이트에서 데이터를 불러온다. 자주 하지 말아야 한다. why?
  # 어떤 경우에는 이렇게 할 수 밖에 없다. 언제?
  html <- read_html(page_url) 
  table <- html %>% html_nodes("table")
  td <- table %>% html_nodes("td") 
  text <- td %>% html_text() 
  text <- gsub("(\r)(\n)(\t)*", "", text)
  mat <- matrix(text, nrow=10, ncol=5, byrow=TRUE)
  mat<-mat[ , 1:4] #홈페이지 링크를 삭제
  df <- as.data.frame(mat)
}

# method 1
mat <- extract(pages[1])
for(i in 2:length(page) ) mat <- rbind(mat, extract(pages[i]))

# method 2  
result <- lapply(pages, extract)
do.call(rbind, result)