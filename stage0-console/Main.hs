module Main where

chat :: IO ()
chat = do
  getLine >>= putStrLn
  chat


main :: IO ()
main = do
  putStrLn "Welcome to the loneliest chat in the world!"
  chat