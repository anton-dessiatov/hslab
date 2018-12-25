module Main where

chat :: IO ()
chat = do
  line <- getLine
  putStrLn line
  chat

main :: IO ()
main = do
  putStrLn "Welcome to the loneliest chat in the world!"
  chat