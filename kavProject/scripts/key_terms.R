library(httr)
library(jsonlite)
# install.packages("twitteR")
library(twitteR)

library(dplyr)
library(plotly)

term_search <- function(key_term, quantity) {
  searched_tweets <- searchTwitter(key_term) 
  tweets <- twListToDF(searched_tweets)
  tweets_tbl <- tweets %>% 
    select(screenName, text) %>% 
    rename("Twitter Handle" = screenName,
           "Tweet" = text)
  return(tweets_tbl)
}

term_top_5 <- function(key_term, num_tweets) {
  sample_tweets <- searchTwitter(key_term,
                                 n = num_tweets) 
  popular_tweets <- twListToDF(sample_tweets)
  popular_tweets <- popular_tweets %>% 
    select(screenName, text, retweetCount) %>%
    arrange(desc(retweetCount)) %>%
    rename("Twitter Handle" = screenName,
           "Number of Retweets" = retweetCount,
           "Tweet" = text) %>% 
    head(5) 
  return(popular_tweets)
}

plot_tweets <- function(dataset) {
  colors <- c('#FF6666', 'FFB266', '#FFFF66', '#66FF66', '#66FFFF')
  bar_plot <- plot_ly(dataset,
                      x = dataset[, 1],
                      y = dataset[, 3],
                      text = dataset[, 3],
                      textposition = 'auto',
                      marker = list(color = colors),
                      type = 'bar',
                      name = 'White') %>%
    layout(title = "Top 5 Tweets from a Random Sample",
           xaxis = list(title = "Twitter Handles"),
           yaxis = list(title = "Number of Retweets"))
  return(bar_plot)
}