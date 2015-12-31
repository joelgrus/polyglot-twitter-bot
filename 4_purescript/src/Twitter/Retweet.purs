-- | Retweeting

module Twitter.Retweet (retweet) where

import Prelude (Unit())
import Data.Function
import Control.Monad.Eff (Eff())

import Twitter

foreign import retweetImpl :: forall eff. Fn2 TwitterClient TweetId (Eff (twitter :: TWITTER | eff) Unit)

retweet :: forall eff. TwitterClient ->
                       TweetId ->
                       Eff (twitter :: TWITTER | eff) Unit
retweet client tweetId = runFn2 retweetImpl client tweetId
