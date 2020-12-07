# Purescript Advent Of Code Starter Kit

This is a Purescript starter kit for [Advent of Code](https://adventofcode.com/) solutions.

## Installation

### Clone the repo and build

Clone the repo and build and run the CLI. This repo will use `npm` to install the latest `purescript` compiler and `spago` build tool in your local directory.

```sh
git clone https://github.com/fpindia/purescript-adventofcode
cd purescript-adventofcode
npm install
npx spago build
npx spago run
```

If this prints a brief help message then you are all set with the dev tools!

### Getting the AdventOfCode cookie

This is needed if you want to be able to automatically download your puzzle input.

- First login to [Advent of Code](https://adventofcode.com).
- Then with Firefox:
   - hit F12 in order to open the developer console
   - go to «Storage» tab, select «Cookies» in the left hand pane
   - Copy the «value» field of the «session» Cookie. On the screenshot, it's the part that starts with «536…»
  ![](docs/aoc-cookie-ff.png)
- Or with Chrome:
   - Right-click, inspect, to open developer tools.
   - Go to «Network» tab, refresh the page to see all the network requests
   - In the left «name» pane, Click on the HTML request. click «Cookies» tab on the right page, and grab the value for «session» cookie.
- Copy the `.env.template` file into `.env`.
- Paste the cookie in the AOC_COOKIE variable. The `.env` file should look like this:
```
AOC_COOKIE="536…"
AOC_INPUT_DIRECTORY="input"
```

You are done ! You should now be able to download the input file by running the `aoc` command.


### Editor setup

We recommend one of the following editor setups -

#### Spacemacs

[Spacemacs](https://www.spacemacs.org/) is a user friendly emacs distribution with excellent inbuilt support for Purescript.

Enable the `purescript` layer by putting the following in your `$HOME/.spacemacs` file, in the `dotspacemacs-configuration-layers` section -

```elisp
  (purescript :variables
     node-add-modules-path t
     psc-ide-use-npm-bin t
     )
```

Restart spacemacs with `<space>-q-R`.

Then open `src/Main.purs` in the editor, and run `<space>-m-m-s` to run the purescript ide server.

#### VSCode

[VSCode](https://code.visualstudio.com/) is a lightweight editor/ide from microsoft.

Install the [purescript-ide](https://github.com/nwolverson/vscode-ide-purescript) plugin by Nicholas Wolverson.

Then open `src/Main.purs` in the editor.


## Usage

### aoc boostrap YEAR DAY

Use `aoc bootstrap` to immediately start coding for a given day.
It downloads the input file, creates a sample module for that day.

Example - To bootstrap the solution for the 5th puzzle in 2020, run `./aoc bootstrap 2020 5`

It will create the following files -``

```
purescript-adventofcode
├── input
│   └── 2020
│       └── 05
└── src
    └── Year2020
        └── Day05.purs
```

The `src/Year2020/Day05.purs` is simple but it contains all you need: 2 methods, `part1` and `part2`, that take as parameter the content of the input file, and return the expected value.

```purescript
module Year2020.Day05 where
...

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
...
```

### aoc run YEAR DAY

Use `aoc run` to quickly run your current solution and measuring the execution time for you.

```
./aoc run 2020 5
Part 1 ==> ...
Obtained in: 0.296ms

Part 2 ==> ...
Obtained in: 0.296ms
```

You can also run only a specific part with the `--part` flag.

```
./aoc run 2020 5 --part1
Part 1 ==> ...
(obtained in 2.1908000235271174e-05 seconds)
```

### aoc download YEAR DAY

Use `aoc download` to quickly download your puzzle input and put it in the correct location.

```
./aoc download 2020 5
```

This will download the input into a file called `inputs/year2020/day5`.

## Helper functions available

This project includes a bignumber library [bignumber](https://github.com/athanclark/purescript-bignumber).

Also included are a bunch of helper functions in `AOC.Lib`.

### Utilities

* ```iterate :: forall a. Int -> (a -> a) -> a -> a```

    Apply a function repeatedly a specified number of times

* ```pipeline :: forall a. a -> Array (a -> a) -> a```

    Successively run an array of functions on a value

* ```eitherToMaybe :: forall e a. Either e a -> Maybe a```

    Convert an either into a maybe

### Bignumber

* ```intToBigNumber :: Int -> BigNumber```

    Convert an integer into a bignumber

### Text splitting

* ```splitFirst :: Pattern -> String -> Maybe {left::String, right::String}```

    Split by a pattern once and return left and right params
      To make multiple splits, use `Data.String.split`

* ```chunk :: Int -> String -> Array String```

    Split a string into chunks of fixed length

### Getting the input

**NOTE:** Normally you won't need to use the below functions, since the input is automatically passed to the `part1` and `part2` functions.

* ```inputFileLocation :: forall aoc. AOC aoc => aoc -> String```

    The location of the input file

* ```readInput :: forall aoc. AOC aoc => aoc -> Effect String```

    Read the entire input file into a single string

### Parsing

* ```preventNaN :: Number -> Maybe Number```

    Turn NaN's into Nothing

* ```parseIntBaseN :: Int -> String -> Maybe Int```

    Parse an integer in specified base

* ```parseInt10 :: String -> Maybe Int```

    Parse an integer

* ```parseFloat :: String -> Maybe Number```

    Parse a float
