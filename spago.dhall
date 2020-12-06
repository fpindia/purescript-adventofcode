{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ name = "advent-of-code"
, dependencies =
  [ "aff"
  , "ansi"
  , "console"
  , "debug"
  , "effect"
  , "foreign-object"
  , "functors"
  , "node-fs"
  , "node-readline"
  , "optparse"
  , "psci-support"
  , "stringutils"
  , "strings"
  , "bignumber"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs" ]
}
