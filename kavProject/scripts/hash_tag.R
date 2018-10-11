library(httr)
library(jsonlite)
# install.packages("twitteR")
library(twitteR)
library(ggplot2)

source("api-keys.R")

setup_twitter_oauth(consumer_public, consumer_private, public_key, private_key)

most_retweeted <- function(term) {
  sample_tweets <- searchTwitter(key_term) 
  popular_tweets <- twListToDF(sample_tweets)
  popular_tweets <- popular_tweets %>% 
    select(text, retweetCount) %>%
    rename("Retweet Count" = retweetCount,
           "Tweet" = text) %>% 
    filter("Retweet Count" = max("Retweet Count"))
  
  return(popular_tweets)
}

plot_tweets_retweet_hash_tag <- function(dataset) {
  bar_plot <-ggplot(dataset, aes("Tweet", "Retweet Count"))
  bar_plot + geom_bar(stat = "identity")  
  
  return(bar_plot)
}
