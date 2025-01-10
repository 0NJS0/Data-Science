library(tm)
library(topicmodels)


corpus <- Corpus(VectorSource(tokens_df$tokens))
dtm <- DocumentTermMatrix(corpus)


row_sums <- rowSums(as.matrix(dtm))
print(row_sums)

dtm <- dtm[row_sums > 0,99 ]


k=3
lda_model <- LDA(dtm, k = k, control = list(seed = 123))

# View top terms
print(terms(lda_model,4))


