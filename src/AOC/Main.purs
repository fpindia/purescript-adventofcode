module AOC.Main where

import Options.Applicative
import Control.Apply ((<*>))
import Control.Bind ((=<<))
import Data.Functor ((<$>))
import Data.Maybe (Maybe, fromMaybe, optional)
import Data.Semigroup ((<>))
import Data.Unit (Unit)
import Effect (Effect)
import Effect.Uncurried as EFn

type Year = Int
type Day = Int
type Part = Int
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

doit :: Command -> Effect Unit
doit (Bootstrap year day) = EFn.runEffectFn2 bootstrap year day
doit (Download year day) = EFn.runEffectFn2 download year day
doit (Run year day mpart) = EFn.runEffectFn3 run year day (fromMaybe 0 mpart)


foreign import bootstrap :: EFn.EffectFn2 Year Day Unit
foreign import download :: EFn.EffectFn2 Year Day Unit
foreign import run :: EFn.EffectFn3 Year Day Part Unit
