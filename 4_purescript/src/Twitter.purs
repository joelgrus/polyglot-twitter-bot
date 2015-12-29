-- | This module defines foreign types and functions for working with
-- | the Twitter library.

module Twitter where

import Prelude
import Data.Foreign (Foreign())
import Control.Monad.Eff (Eff())

-- | Effect type for interacting with Twitter.
foreign import data TWITTER :: !

-- | The Twitter client returned by the Javascript `Twitter()` constructor.
foreign import data TwitterClient :: *

-- | Credentials for authenticating to Twitter.
type Credentials = {
  consumer_key :: String,
  consumer_secret :: String,
  access_token_key :: String,
  access_token_secret :: String
}

-- | Use credentials to get a Twitter client.
foreign import twitterClient :: forall eff. Credentials -> Eff (twitter :: TWITTER | eff) TwitterClient

type TweetId = String

-- | Record respresenting a tweet. Not complete at all.
type Tweet = {
  id :: TweetId,
  user :: String,
  text :: String
}

type Tweets = Array Tweet
