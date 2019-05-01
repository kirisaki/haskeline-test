module Main where

import System.Console.Haskeline

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
    runInputT defaultSettings (withInterrupt loop)

