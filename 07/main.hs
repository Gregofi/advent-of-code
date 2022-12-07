{-# LANGUAGE PatternGuards #-}
import Data.List

---------------- String manipulation functions ------------------
prefix :: String -> String -> Bool
prefix [] _ = True
prefix _ [] = False
prefix (h1:t1) (h2:t2)
    | h1 == h2 = prefix t1 t2
    | otherwise = False


removePrefix :: String -> String -> String
removePrefix [] s = s
removePrefix _ [] = []
removePrefix (h1:t1) (h2:t2)
    | h1 == h2 = removePrefix t1 t2
    | otherwise = h2:t2


split :: String -> String -> [String]
split _ "" = []
split delim str | prefix delim str = "":split delim (removePrefix delim str)
split delim (h:t) = case split delim t of
                        [] -> [h:""]
                        (head:tail) -> (h:head):tail

------------------------------------------------------------------

data File = Regular Int | Directory [File]

takeUntil :: (a -> Bool) -> [a] -> [a]
takeUntil _ [] = []
takeUntil p (x:xs) = if p x then [] else x : takeUntil p xs

dropUntil :: (a -> Bool) -> [a] -> [a]
dropUntil _ [] = []
dropUntil p (x:xs) = if p x then x:xs else dropUntil p xs

getFileSize :: String -> Int
getFileSize file = let (size:_) = split " " file
                in read size :: Int

-- Handles all commands up until '$ cd ..'
parseCommands :: [String] -> (Int, [String])
parseCommands [] = (0, [])
parseCommands (c:t) | "$ cd .." `isPrefixOf` c = (0, t)
                    | Just dir <- stripPrefix "$ cd " c = (innerDirSize + dirSize, rest)
                    | otherwise = (0, c:t)
                        where (innerDirSize, restCommands) = parseDir t
                              (dirSize, rest) = parseCommands restCommands

parseDir :: [String] -> (Int, [String])
-- First command is always 'ls' of the directory, we can safely ignore that
parseDir (_:t) = if fileSize <= 100000 then (sizeSum, rest) else (innerDirsSize, rest)
    where files = takeUntil (\x -> head x == '$') t
          fileSize = sum $ map getFileSize $ filter (\(h:_) -> h /= 'd') files
          commands = dropUntil (\x -> head x == '$') t
          (innerDirsSize, rest) = parseCommands commands
          sizeSum = innerDirsSize + fileSize


main = do
    file <- getContents
    let lins = lines file
    print $ parseCommands lins

