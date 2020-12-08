module Main where

import Control.Bind (discard)
import Data.Unit (Unit)
import Effect (Effect)
import Effect.Class.Console (log)

main :: Effect Unit
main = do
  log "Hello! You have successfully built the project!"
  log "This code resides in `src/Main.purs`. Feel free to delete/modify it as per your needs."
  log "Start by running './aoc'"
