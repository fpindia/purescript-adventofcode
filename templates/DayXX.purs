module Year[__YEAR__].Day[__DAY__] where

import Control.Bind (bind, discard)
import Control.Category ((<<<))
import Data.Array as A
import Data.Foldable (product)
import Data.Function (($))
import Data.Functor (map, (<$>))
import Data.Int (round)
import Data.Maybe (Maybe(..))
import Data.Ring ((-))
import Data.Semigroup ((<>))
import Data.Show (show)
import Data.Unit (Unit)
import Effect (Effect)
import Effect.Class.Console (log)
import Util.Input (readInputLines)
import Util.Parse (unsafeParseInt10)

--------------------------------------------------------------------------------
-- Write your solutions here

part1 :: String -> Effect Unit
part1 input = do
  let result = "<TODO>"
  log $ "Part 1 ==> " <> result

part2 :: String -> Effect Unit
part2 = do
  let result = "<TODO>"
  log $ "Part 2 ==> " <> result


--------------------------------------------------------------------------------
-- IMPORTANT: Don't modify anything below this
-- Automatic metadata detection
data AOC_[__YEAR__]_[__DAY__] = AOC_[__YEAR__]_[__DAY__]
aoc :: AOC_[__YEAR__]_[__DAY__]
aoc = AOC_[__YEAR__]_[__DAY__]
instance aoc_[__YEAR__]_[__DAY__] :: AOC AOC_[__YEAR__]_[__DAY__] where
  day = "[__DAY__]"
  year = "[__YEAR__]"
