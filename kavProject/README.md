# TeamBD5-Final-Project

## Project Description

### What is the dataset we are working with?  

The dataset we are working with is data sourced from the **Twitter API** associated with the activity of Twitter users. The relevant information that will be used throughout this project is collected by Twitter through their **standard** search API that samples recent Tweets published in the past _7 days_. This data will subsequently be used to analyze the level of social acceptance and trends of various politicians. This project will also be formatted as a **live website** that will be intuitive and visually appealing for the end users. As a result, the use of this data will provide the user with _detailed_ information related to various politicians in order to gain a better understanding of the current/recent political field.

### Who is the target audience?

Our target audience is the wide umbrella of _individuals_ or _groups_ that are interested in data related to various politicians. These groups or individuals include, but are not limited to, politicians, political news reporters/journalists, and political campaign staff. The reason as to why they would be interested in our data, would be because they want to understand how certain politicians are viewed by the public. Access to this information will allow them to adjust their political strategies depending on the results. For instance, **political campaign staff** in particular, may be interested in using our dataset because they can estimate how their politicians are viewed in general through what words are largely related to the politician and set their election strategies and target their voters accordingly.

### What does your audience want to learn from your data?

More specifically, our dataset could provide political campaign staff with information addressing three important queries:
- **Firstly**, the data could show them how their own politicians are viewed by the public through analyzing the trends of vocabulary/terms that are generally associated with them.
- **Secondly**, the dataset could be used to understand how opposing politicians are viewed by the public and provide information that could be leveraged while setting election strategies to precisely address their policies and perhaps move their voters.
- **Thirdly**, political campaign staff could learn what have been the most popular and/or controversial policies of certain politicians to better understand the American public's interest and to design more effective political agendas for their campaigns.

## Technical Description
We will be reading this data via Twitter's API
**[Search Tweets](https://developer.twitter.com/en/docs/tweets/search/overview)**
feature. We settled on just using the Standard _(free)_ of this search
API, that only allows a sample size of tweets from the past 7 weeks.
The type of data wrangling we're planning to do is **reshaping the data** to fit our search query.
We don't have any new packages to use for this library yet, we're planning to use the usual ones _(dplyr, ggplot2/plotly)_ until we deeply dive into this API to find **unfamiliar complexities that would require new libraries/packages.** The major challenges we anticipate to have are having **trouble data wrangling and implementing** that data to a Shiny application. Also, knowing how to **utilize the parameters and queries** provided by the API to do what we are planning to do.
