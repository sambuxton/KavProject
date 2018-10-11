library(httr)
library(jsonlite)
# install.packages("twitteR")
library(twitteR)
library(dplyr)
# install.packages("RCurl")
library(RCurl)
# install.packages("tm")
library(tm)
# install.packages("sentimentr")
library(sentimentr)
# install.packages("wordcloud")
library(wordcloud)

source("./api-keys.R")

setup_twitter_oauth(consumer_public, consumer_private, public_key, private_key)

# Build wordcloud
build_wordcloud <- function(key_term) {
  # Sample Tweets
  Sampletweets <- searchTwitter(key_term, lang = "en", n = 300, 
                                resultType = "recent")
  Sampletweets_text <- sapply(Sampletweets, function(x) x$getText())

  # Build corpus
  Sampletweets_corpus <- Corpus(VectorSource(Sampletweets_text))

  # Edit Sample Tweets Corpus
  Sampletweets_corpus <- tm_map(Sampletweets_corpus, tolower)
  Sampletweets_corpus <- tm_map(Sampletweets_corpus, removePunctuation)
  Sampletweets_corpus <- tm_map(Sampletweets_corpus, removeWords, 
                                stopwords("english"))
  Sampletweets_corpus <- tm_map(Sampletweets_corpus, stripWhitespace)

  # If you want to remove search words because they will obviously be frequent
  Sampletweets_corpus <- tm_map(Sampletweets_corpus, removeWords, 
                                c("trump", "president", "america", "hillary"))

  # Create word cloud
  wordcloud(Sampletweets_corpus)
}