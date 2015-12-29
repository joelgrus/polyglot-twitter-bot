-- | Retweeting

module Twitter.Retweet (retweet) where

import Prelude (Unit())
import Data.Foreign (Foreign())
import Data.Function
import Control.Monad.Eff (Eff())

import Twitter

foreign import retweetImpl :: forall eff. Fn2 TwitterClient TweetId (Eff (twitter :: TWITTER | eff) Unit)

retweet :: forall eff. TwitterClient ->
                       TweetId ->
                       Eff (twitter :: TWITTER | eff) Unit
retweet = runFn2 retweetImpl
