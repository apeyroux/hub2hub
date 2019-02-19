{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ExtendedDefaultRules #-}
{-# OPTIONS_GHC -fno-warn-type-defaults #-}

module Main where

import Shelly
import System.Environment
import Control.Exception.Base

import qualified Data.Text as T
import qualified Data.Text.IO as TIO

default (T.Text)

main :: IO ()
main = do
  [images, hub] <- getArgs
  f <- TIO.readFile images
  shellyFailDir $
    mapM_ (\x -> catch_sh (do
                              echo "pull ..."
                              run_ "docker" ["pull", x]
                              echo "tag ..."
                              run_ "docker" ["tag", x, T.pack hub <> "/" <> x]
                              echo "push ..."
                              run_ "docker" ["push", T.pack hub <> "/" <> x]
                          ) (\e -> echo ("Oops: " <> (T.pack $ show (e :: IOException))))
          ) $ T.splitOn "\n" f
