library(shiny)
library(httr)
library(jsonlite)
library(plotly)
library(dplyr)
library(ggplot2)
# install.packages("twitteR")
library(twitteR)
library(stringr)

source("api-keys.R")
source("./scripts/key_terms.R")

# Sets up access key
setup_twitter_oauth(consumer_public, consumer_private, public_key, private_key)

shinyServer(
  function(input, output) {
    output$key_tweets <- renderTable({
      return(term_search(input$term))
    })
    tweets <- reactive({
      popular <- return(term_top_5(input$top_5, input$quantity))
    })
    output$tweets_plot <- renderPlotly({
      return(plot_tweets(tweets()))
    })
    output$tweets_tbl <- renderTable({
      tweets()[, c("Twitter Handle", "Tweet", "Number of Retweets")]
    })
    
    # Function which evaluates sentiment of a sentence
    score.sentiment = function(sentences, pos.words, neg.words, .progress='none')
    {
      require(plyr)
      require(stringr)
      
      # we got a vector of sentences. plyr will handle a list or a vector as an "l" for us
      # we want a simple array of scores back, so we use "l" + "a" + "ply" = laply:
      scores = laply(sentences, function(sentence, pos.words, neg.words) {
        
        # clean up sentences with R's regex-driven global substitute, gsub():
        sentence = gsub('[[:punct:]]', '', sentence)
        sentence = gsub('[[:cntrl:]]', '', sentence)
        sentence = gsub('\\d+', '', sentence)
        # and convert to lower case:
        sentence = tolower(sentence)
        
        # split into words. str_split is in the stringr package
        word.list = str_split(sentence, '\\s+')
        # sometimes a list() is one level of hierarchy too much
        words = unlist(word.list)
        
        # compare our words to the dictionaries of positive & negative terms
        pos.matches = match(words, pos.words)
        neg.matches = match(words, neg.words)
        
        # match() returns the position of the matched term or NA
        # we just want a TRUE/FALSE:
        pos.matches = !is.na(pos.matches)
        neg.matches = !is.na(neg.matches)
        
        # and conveniently enough, TRUE/FALSE will be treated as 1/0 by sum():
        score = sum(pos.matches) - sum(neg.matches)
        
        return(score)
      }, pos.words, neg.words, .progress=.progress )
      
      scores.df = data.frame(score=scores, text=sentences)
      return(scores.df)
    }
    
    #Accesses sentiment dictionary of tidyverse words
    dictionary <- as.data.frame(get_sentiments("afinn"))
    positive_words <- dictionary[dictionary$score > 0, 1]
    negative_words <- dictionary[dictionary$score < 0, 1]

    # Puts twitter data into analyzable format, gives each tweet a score
    output$plot <- renderPlot({
      tweet_info <- searchTwitter(paste0("#", input$hashtag), 50)
      tweet_info_df <- twListToDF(tweet_info)
      tweet_info_df$sentiment <- score.sentiment(tweet_info_df$text, positive_words, negative_words, .progress = 'none')[,1]
      
      # Separates info into negative tweets and positive tweets
      negative_tweet_info <- tweet_info_df[tweet_info_df$sentiment < 0, ]
      positive_tweet_info <- tweet_info_df[tweet_info_df$sentiment > 0, ]
      
      # Counts up the number of positive and negative retweets
      total_negative <- sum(negative_tweet_info$retweetCount)
      total_positive <- sum(positive_tweet_info$retweetCount)
      total <- data.frame("positive" = total_positive, "negative" = total_negative)
      
      # Plots information
      vector <- c(total$negative, total$positive)
      
      final_plot <- barplot(vector, main="Attitude About Kavanaugh", xlab="Attitude", ylab="Number of People", names.arg=c("Positive","Negative"),
                            border="red", density=c(90, 70, 50, 40, 30, 20, 10))
 

      
    })
})

