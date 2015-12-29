module Main where

import Prelude
import Control.Monad.Eff
import Control.Monad.Eff.Console
import qualified Data.Array as Array
import Data.Maybe
import qualified Data.String.Regex as Regex

import MyCredentials
import Twitter
import Twitter.Search2
import Twitter.Retweet
import Twitter.Streaming

findAndRetweet :: SearchOptions ->
                  Maybe Regex.Regex ->
                  TwitterClient ->
                  Eff (twitter :: TWITTER, console :: CONSOLE) Unit
findAndRetweet options rgx client = search client options retweetMatches
  where
    retweetMatches tweets = do
      foreachE (Array.filter rgxFilter tweets) (\tweet -> retweet client tweet.id)
    rgxFilter tweet = case rgx of
      Just pattern -> Regex.test pattern tweet.text
      Nothing -> true

streamAndLog :: TwitterClient -> Eff (console :: CONSOLE, twitter :: TWITTER) Unit
streamAndLog client = stream client options logTweet logError
  where
    options = streamOptions "trump"
    logTweet tweet = log ("(" ++ tweet.id ++ ") " ++ tweet.user ++ ": " ++ tweet.text)
    logError = log

main :: Eff (console :: CONSOLE, twitter :: TWITTER) Unit
main = twitterClient myCredentials >>= (findAndRetweet options rgx)
  where
    query = "make \"great again\" -america -filter:retweets"
    options = searchOptions query
    rgx = Just $ Regex.regex "make (.*) great again" flags
    flags = Regex.noFlags { ignoreCase = true }
