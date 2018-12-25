module Main where

import Options.Applicative
  ( Parser, ParserInfo
  , flag', long, help, strOption, value, info, helper
  , fullDesc, progDesc, header, (<**>)
  , execParser
  )
import System.IO (hFlush, stdout)

newtype Arguments = Arguments
  { prompt :: String
  }

chat :: Arguments -> IO ()
chat args = do
  putStr $ prompt args
  hFlush stdout
  line <- getLine
  putStrLn line
  chat args

argsParser :: Parser Arguments
argsParser = Arguments 
  <$> strOption 
      (long "prompt" <> help "What prompt would you like to have" <> value ">")

argsInfo :: ParserInfo Arguments
argsInfo = info (argsParser <**> helper)
  ( fullDesc
 <> progDesc "The loneliest chat in the world"
 <> header "hslab - come get some")

main :: IO ()
main = do
  args <- execParser argsInfo
  putStrLn "Welcome to the loneliest chat in the world!"
  chat args