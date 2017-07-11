#############################################################################################################################################
# PACKAGE MGMT
#############################################################################################################################################

# pkg
library(streamR)
library(RCurl)
library(RJSONIO)
library(stringr)
library(ROAuth)

# setwd
setwd("C:/Users/akruse/Documents/Projekte_Weitere/crypto")

#############################################################################################################################################
# AUTH
#############################################################################################################################################

# specify params
requestURL = "https://api.twitter.com/oauth/request_token"
accessURL = "https://api.twitter.com/oauth/access_token"
authURL = "https://api.twitter.com/oauth/authorize"
consumerKey = 
consumerSecret = 

# set auth
my_oauth = OAuthFactory$new(consumerKey = consumerKey,
                             consumerSecret = consumerSecret,
                             requestURL = requestURL,
                             accessURL = accessURL,
                             authURL = authURL)

# do handshake
my_oauth$handshake(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl"))

# save auth for later use
save(my_oauth, file = "my_oauth.Rdata")

#############################################################################################################################################
# GETTING THE DATA FROM TWITTER
#############################################################################################################################################

# load auth
load("my_oauth.Rdata")

# start grab tweets
filterStream(file.name = "tweets.json",
             track = c("bitcoin"),
             language = "en",
             #location = c(-119, 33, -117, 35),
             timeout = 60,
             oauth = my_oauth)

# format tweets to data frame
tweets.df = parseTweets("tweets.json", simplify = FALSE)
