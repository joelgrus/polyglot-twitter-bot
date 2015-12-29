module TweetBot where

import Prelude
import Control.Monad.Eff
import Control.Monad.Eff.Console
import qualified Data.Array as Array
import Data.Maybe
import qualified Data.String.Regex as Regex

import MyCredentials
import AWS.Lambda.Context
import Twitter
import Twitter.Search
import Twitter.Retweet
import Twitter.Streaming

findAndRetweet :: SearchOptions ->
                  Maybe Regex.Regex ->
                  Context ->
                  TwitterClient ->
                  Eff (lambda :: LAMBDA, twitter :: TWITTER, console :: CONSOLE) Unit
findAndRetweet options rgx context client = search client options retweetMatches
  where
    retweetMatches tweets = do
      foreachE (Array.filter rgxFilter tweets) (\tweet -> retweet client tweet.id)
      succeed context "success"
    rgxFilter tweet = case rgx of
      Just pattern -> Regex.test pattern tweet.text
      Nothing -> true

handler :: Context -> Eff (lambda :: LAMBDA, console :: CONSOLE, twitter :: TWITTER) Unit
handler context = twitterClient myCredentials >>= findAndRetweet options rgx context
  where
    query = "make \"great again\" -america -filter:retweets"
    options = searchOptions query
    rgx = Just $ Regex.regex "make (.*) great again" flags
    flags = Regex.noFlags { ignoreCase = true }
