
library(tm)
library(topicmodels)
library(SnowballC)


file_path <- "D://Educational/AIUB sem 9/MID/Data Science/Project2.csv"
data <- read.csv(file_path, stringsAsFactors = FALSE)

corpus <- Corpus(VectorSource(data$tokens))


dtm <- DocumentTermMatrix(corpus)


tfidf <- weightTfIdf(dtm)

print(tfidf)


row_totals <- apply(dtm, 1, sum)
dtm <- dtm[row_totals > 0, ] 
k <- 5  

lda_model <- LDA(dtm, k = k, control = list(seed = 123))

topic_term_weights <- posterior(lda_model)$terms

print("Topics with token weights:")
for (i in 1:k) {
  cat(sprintf("\nTopic %d:\n", i))

  token_weights <- sort(topic_term_weights[i, ], decreasing = TRUE)
  top_tokens <- head(token_weights, 10)
  
  for (token in names(top_tokens)) {
    cat(sprintf("%s (%.4f)\n", token, top_tokens[token]))
  }
}


