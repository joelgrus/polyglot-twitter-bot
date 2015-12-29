module Twitter.Streaming where

import Prelude (Unit())
import Data.Foreign (Foreign())
import Data.Function
import Control.Monad.Eff (Eff())

import Twitter

type StreamError = String

type StreamOptions = {
  track :: String
}

streamOptions :: String -> StreamOptions
streamOptions q = { track : q }

foreign import streamImpl :: forall eff. Fn4 TwitterClient
                                             StreamOptions
                                             (Tweet -> Eff (twitter :: TWITTER | eff) Unit)
                                             (StreamError -> Eff (twitter :: TWITTER | eff) Unit)
                                             (Eff (twitter :: TWITTER | eff) Unit)


stream :: forall eff. TwitterClient ->
                      StreamOptions ->
                      (Tweet -> Eff (twitter :: TWITTER | eff) Unit) ->
                      (StreamError -> Eff (twitter :: TWITTER | eff) Unit) ->
                      Eff (twitter :: TWITTER | eff) Unit
stream = runFn4 streamImpl
