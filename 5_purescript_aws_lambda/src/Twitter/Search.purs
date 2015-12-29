-- | The search functionality for the Twitter API.

module Twitter.Search where

import Prelude (Unit())
import Data.Foreign (Foreign())
import Data.Maybe
import Control.Monad.Eff (Eff())

import Twitter

type SearchOptions = {
  q :: String,
  count :: Int
}

searchOptions :: String -> SearchOptions
searchOptions query = {
  q : query,
  count : 15
}

foreign import search :: forall eff. TwitterClient ->
                          SearchOptions ->
                          (Tweets -> Eff (twitter :: TWITTER | eff) Unit) ->
                          Eff (twitter :: TWITTER | eff) Unit
