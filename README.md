
![App Brewery Banner](Documentation/AppBreweryBanner.png)

#  Twittermenti




>This is a companion project to The App Brewery's Complete App Developement Bootcamp, check out the full course at [www.appbrewery.co](https://www.appbrewery.co/)

![End Banner](Documentation/readme-end-banner.png)

## Denis' Notes

* How will this app use Twitter data and/or APIs?
  - This app uses machine learning to understand tweet sentiment.
* How will this app analyze Twitter data including any analysis of Tweets or Twitter users?
  - This app will analyze the last 100 tweets that include a particular handle, such as @Apple, at the moment the user queries for a handle. The analysis is done by a machine learning model.
  - The machine learning module included in this app already has trained data constiting of tweets about Apple corporation that were extracted from a Twitter dataset created by Sanders Analytics.
  - The dataset has been described here:
    http://boston.lti.cs.cmu.edu/classes/95-865-K/HW/HW3/
    and was obtained here:
    http://boston.lti.cs.cmu.edu/classes/95-865-K/HW/HW3/twitter-sanders-apple3.zip
  - Based on this dataset, the machine learning module will analyze tweets based on a particular handle, for example, @Apple, and give feedback on the estimated sentiment of the tweet.
* Will this app use Tweet, Retweet, like, follow, or Direct Message functionality?
- No.
* Are there plans to display Tweets or aggregate data about Twitter content outside of Twitter?
- No.
* Will this app, service or analysis make Twitter content or derived information available to a government entity?
- No.
