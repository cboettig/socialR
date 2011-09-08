require(tm)
require(wordcloud)
require(RColorBrewer)

carl <- read.csv("searchterms.csv", colClasses=c("character", "numeric"))

words <- character(sum(carl[[2]]))
m <- 1
for(i in 1:length(carl[[1]])){
  n <- carl[[2]][i]
  x <- carl[[1]][i]
  words[m:(m+(n-1))] <- rep(x, n)
  m <- m+n
}

 carl <- Corpus(DataframeSource(carl))
 carl <- tm_map(carl, removePunctuation)
 carl <- tm_map(carl, tolower)

 carl.tdm <- TermDocumentMatrix(carl)
 carl.m <- as.matrix(carl.tdm)
 carl.v <- sort(rowSums(carl.m), decreasing=TRUE)
 carl.d <- data.frame(word=names(carl.v), freq=carl.v)

pal2 <- brewer.pal(8,"Dark2")

png("wordcloud.png", width=1280,height=1280)
wordcloud(carl.d$word,carl.d$freq, scale=c(8,.2),min.freq=1,
max.words=Inf, random.order=FALSE, rot.per=.15, colors=pal2)
dev.off()

require(socialR)
upload("wordcloud.png", script="wordcloud.R")
