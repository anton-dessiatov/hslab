module Main where

import Control.Applicative ((<|>))
import Control.Monad (forever)
import Data.Word (Word16)
import Data.Streaming.Network 
  ( HasReadWrite (..), ServerSettings, serverSettingsTCP
  , runTCPServer, appRead, appWrite
  )
import Options.Applicative
  ( Parser, ParserInfo
  , flag', long, help, option, auto, value, info, helper
  , fullDesc, progDesc, header, (<**>)
  , execParser
  )

import qualified Data.ByteString.Char8 as B

data Backend
  = BackendConsole
  | BackendNetwork ServerSettings

newtype Arguments = Arguments 
  { argumentsBackend :: Backend
  }

backendConsole :: Parser Backend
backendConsole = flag' BackendConsole
  (  long "console"
  <> help "Run chat locally in console"
  )

backendNetwork :: Parser Backend
backendNetwork = (\x y -> BackendNetwork $ serverSettingsTCP x y)
  <$> option auto (long "port" <> help "TCP port number to listen at")
  <*> option auto (long "bind" <> help "Address binding" <> value "*")

argsParser :: Parser Arguments
argsParser = Arguments <$> (backendConsole <|> backendNetwork)

argsInfo :: ParserInfo Arguments
argsInfo = info (argsParser <**> helper)
  ( fullDesc
 <> progDesc "Trivial echo"
 <> header "hslab - trivial echo")

chat :: HasReadWrite conn => conn -> IO ()
chat conn = forever $
  appRead conn >>= appWrite conn

data ConsoleReadWrite = ConsoleReadWrite

-- This was written by a fellow expert haskeller we've asked for help.
-- For reference: these are not proper lens.
instance HasReadWrite ConsoleReadWrite where
  readLens f a = const a <$> f (B.pack <$> getLine)
  writeLens f a = const a <$> f (putStrLn . B.unpack)
  
main :: IO ()
main = do 
  args <- execParser argsInfo
  case argumentsBackend args of 
    BackendConsole -> chat ConsoleReadWrite
    BackendNetwork ss -> runTCPServer ss chat