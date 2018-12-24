module Main where

import Reflex.Dom

main :: MonadWidget t m => m ()
main = mainWidget $ el "div" $ text "This is where overkill for generating a simple web page gets dangerously huge"