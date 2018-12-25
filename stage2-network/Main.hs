module Main where

import Data.Streaming.Network

chat :: AppData -> IO ()
chat conn = do
  appRead conn >>= appWrite conn
  chat conn

main :: IO ()
main = runTCPServer (serverSettingsTCP 1234 "*") $ \conn -> do
  putStrLn "Hello again"
  chat conn
