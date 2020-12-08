{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ name = "advent-of-code"
, dependencies =
  [ "aff"
  , "ansi"
  , "bignumber"
  , "console"
  , "debug"
  , "effect"
  , "foreign-object"
  , "functors"
  , "node-fs"
  , "node-readline"
  , "optparse"
  , "parsing"
  , "free"
  , "psci-support"
  , "stringutils"
  , "strings"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs" ]
}
