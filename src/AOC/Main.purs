module AOC.Main where

import Options.Applicative

import AOC.Lib (inputFileLocationYearDay)
import Control.Apply ((<*>))
import Control.Bind (bind, discard, (=<<))
import Data.Functor ((<$>))
import Data.Maybe (Maybe, fromMaybe, optional)
import Data.Semigroup ((<>))
import Data.Show (show)
import Data.Unit (Unit)
import Effect (Effect)
import Effect.Uncurried as EFn
import Node.Path (FilePath)

type Year = Int
type Day = Int
type Part = Int
type Cookie = String
data Command = Bootstrap Year Day | Download Year Day | Run Year Day (Maybe Part)

configOptions :: Parser Command
configOptions = subparser
  ( command "bootstrap" (info bootstrapOptions ( progDesc "Bootstrap a solution for a particular day" ))
 <> command "download" (info downloadOptions ( progDesc "Download the puzzle input for a particular day" ))
 <> command "run" (info runOptions ( progDesc "Run the solution for a particular day" ))
  )

bootstrapOptions :: Parser Command
bootstrapOptions =
  Bootstrap
      <$> argument int ( metavar "YEAR" )
      <*> argument int ( metavar "DAY" )

downloadOptions :: Parser Command
downloadOptions =
  Download
      <$> argument int ( metavar "YEAR" )
      <*> argument int ( metavar "DAY" )

runOptions :: Parser Command
runOptions =
  Run
      <$> argument int ( metavar "YEAR" )
      <*> argument int ( metavar "DAY" )
      <*> optional (option int
         ( long "part"
         <> short 'p'
         <> metavar "PART"
         <> help "Use this to run only part 1 or part 2 from that day. Valid options are 1 or 2" ))

main :: Effect Unit
main = doit =<< execParser opts

opts :: ParserInfo Command
opts = info (configOptions <**> helper)
  ( fullDesc
  <> progDesc "Run a command. One of - bootstrap | download | run"
  <> header "aoc - A Purescript Advent of Code starter kit" )

foreign import aoc_cookie :: Effect String

doit :: Command -> Effect Unit
doit (Bootstrap year day) = do
  doit (Download year day)
  EFn.runEffectFn2 bootstrap year day
doit (Download year day) = do
  cookie <- aoc_cookie
  loc <- inputFileLocationYearDay (show year) (show day)
  EFn.runEffectFn4 download year day cookie loc
doit (Run year day mpart) = do
  loc <- inputFileLocationYearDay (show year) (show day)
  EFn.runEffectFn4 run year day (fromMaybe 0 mpart) loc


foreign import bootstrap :: EFn.EffectFn2 Year Day Unit
foreign import download :: EFn.EffectFn4 Year Day Cookie FilePath Unit
foreign import run :: EFn.EffectFn4 Year Day Part String Unit
