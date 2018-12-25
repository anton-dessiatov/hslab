module Main where

import Control.Monad (forever, forM_)
import Data.Default (def)
import Reflex.Dom

import qualified Data.Text as T

main :: IO ()
main = mainWidget $ el "div" $ do
  t <- el "div" $ textInput def 
  lines <- foldDyn (:) [] (tagPromptlyDyn (_textInput_value t) (keypress Enter t))

  el "div" $ do
    let render x = forM_ x (el "div" . text)
    dyn_ $ render <$> lines
