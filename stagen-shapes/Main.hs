module Main where

newtype Width = Width Double
  deriving (Show)
newtype Height = Height Double
  deriving (Show)
newtype Radius = Radius Double
  deriving (Show)

data Shape
  = Rect Width Height
  | Circle Radius
  deriving (Show)

perimeter :: Shape -> Double
perimeter (Rect (Width w) (Height h)) = 2 * (w + h)
perimeter (Circle (Radius r)) = 2 * pi * r

area :: Shape -> Double
area (Rect (Width w) (Height h)) = w * h
area (Circle (Radius r)) = pi * r * r

main :: IO ()
main = putStrLn "Load it to GHCi and have fun"
