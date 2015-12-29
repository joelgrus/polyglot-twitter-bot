-- | The search functionality for the Twitter API.

module Twitter.Search2 where

import Prelude (Unit())
import Data.Foreign (Foreign())
import Data.Function
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

foreign import searchImpl :: forall eff. Fn3
                                         TwitterClient
                                         SearchOptions
                                         (Tweets -> Eff (twitter :: TWITTER | eff) Unit)
                                         (Eff (twitter :: TWITTER | eff) Unit)

search :: forall eff. TwitterClient ->
                      SearchOptions ->
                      (Tweets -> Eff (twitter :: TWITTER | eff) Unit) ->
                      (Eff (twitter :: TWITTER | eff) Unit)
search = runFn3 searchImpl
