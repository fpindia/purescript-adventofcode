module AOC.Lib where

import Control.Applicative (pure)
import Control.Bind (bind, (=<<))
import Data.Array as A
import Data.BigNumber (BigNumber, parseBigNumber)
import Data.Boolean (otherwise)
import Data.Either (Either(..))
import Data.EuclideanRing ((-))
import Data.Foldable (foldl)
import Data.Function (($))
import Data.Functor ((<$>))
import Data.Int (round)
import Data.Maybe (Maybe(..))
import Data.Ord ((<=), (>))
import Data.Semigroup ((<>))
import Data.Show (show)
import Data.String as S
import Data.String.Pattern (Pattern)
import Data.Unit (Unit)
import Effect (Effect)
import Global (isNaN)
import Node.Encoding (Encoding(..))
import Node.FS.Sync (readTextFile, writeTextFile)
import Unsafe.Coerce (unsafeCoerce)


--------------------------------------------------------------------------------
-- Utilities

-- | Apply a function repeatedly a specified number of times
iterate :: forall a. Int -> (a -> a) -> a -> a
iterate i f a
  | i > 0 = iterate (i-1) f (f a)
  | otherwise = a

-- | Successively run an array of functions on a value
pipeline :: forall a. a -> Array (a -> a) -> a
pipeline a fs = foldl (\a' f -> f a') a fs

-- | Convert an either into a maybe
eitherToMaybe :: forall e a. Either e a -> Maybe a
eitherToMaybe (Left _) = Nothing
eitherToMaybe (Right a) = Just a

--------------------------------------------------------------------------------
-- Bignumber

-- HACKY!
-- | Convert an integer into a bignumber
intToBigNumber :: Int -> BigNumber
intToBigNumber x = case parseBigNumber (show x) of
  Left _ -> unsafeCoerce "IMPOSSIBLE: fromInt: INVALID BIGNUM!"
  Right y -> y

--------------------------------------------------------------------------------
-- Text splitting

-- | Split by a pattern once and return left and right params
-- | To make multiple splits, use `Data.String.split`
splitFirst :: Pattern -> String -> Maybe {left::String, right::String}
splitFirst p s = do
  let arr = S.split p s
  x <- A.uncons arr
  y <- A.uncons x.tail
  pure {left:x.head, right: y.head}

-- | Split a string into chunks of fixed length
chunk :: Int -> String -> Array String
chunk len contents
  | S.length contents <= 0 = []
  | otherwise =
      let res = S.splitAt len contents
      in A.cons res.before (chunk len res.after)

--------------------------------------------------------------------------------
-- Getting the input

foreign import getInputDirectory :: Effect String

-- | The location of the input file, given a year and day
inputFileLocationYearDay :: String -> String -> Effect String
inputFileLocationYearDay y d = do
  inputDirectory <- getInputDirectory
  pure $ inputDirectory <> "/year" <> y <> "/day" <> d

-- | Read the entire input file into a single string, given a year and day
readInputYearDay :: String -> String -> Effect String
readInputYearDay year day = readTextFile UTF8 =<< inputFileLocationYearDay year day

-- | Write the input file, given a year and day
writeInputYearDay :: String -> String -> String -> Effect Unit
writeInputYearDay year day contents = do
  loc <- inputFileLocationYearDay year day
  writeTextFile UTF8 loc contents


--------------------------------------------------------------------------------
-- Parsing

-- These return `Number` instead of `Int` because they can return `NaN`
foreign import unsafeParseIntBase :: String -> Int -> Number
foreign import unsafeParseInt10 :: String -> Number
foreign import unsafeParseFloat :: String -> Number

-- | Turn NaN's into Nothing
preventNaN :: Number -> Maybe Number
preventNaN n
  | isNaN n = Nothing
  | otherwise = Just n

-- | Parse an integer in specified base
parseIntBaseN :: Int -> String -> Maybe Int
parseIntBaseN n s = round <$> preventNaN (unsafeParseIntBase s n)

-- | Parse an integer
parseInt10 :: String -> Maybe Int
parseInt10 s = round <$> preventNaN (unsafeParseInt10 s)

-- | Parse a float
parseFloat :: String -> Maybe Number
parseFloat s = preventNaN (unsafeParseFloat s)
