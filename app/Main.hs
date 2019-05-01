module Main where

import System.Console.Haskeline
import qualified Data.List as L

main :: IO ()
main =
  let
    loop :: InputT IO ()
    loop = handle (\Interrupt -> loop) $ do
      minput <- getInputLine "% "
      case minput of
        Nothing -> return ()
        Just "quit" -> return ()
        Just input -> do
          outputStrLn $ "Input was: " ++ input
          loop
  in do
    runInputT setting (withInterrupt loop)

search :: String -> [Completion]
search str = fmap simpleCompletion $ filter (L.isPrefixOf str)
             [ "hoge"
             , "fuga"
             , "piyo"
             ]

setting :: Settings IO
setting = Settings { historyFile = Nothing
                   , complete = completeWord Nothing " \t" $ pure . search
                   , autoAddHistory = True
                   }
