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

data File = Directory Int [File] deriving (Eq, Show, Read)

-- Returns new Directory where sums of all subdirectories are contained in the
-- size of the directory itself
prefixSum :: File -> File
prefixSum (Directory size []) = Directory size []
prefixSum (Directory size dirs) = Directory sum summed
    where summed = map prefixSum dirs
          sum = size + foldl (\acc (Directory size _) -> acc + size) 0 summed

-- Flatten directories into list of sizes
flatten :: File -> [Int]
flatten (Directory size []) = [size]
flatten (Directory size lst) = size : foldl (\acc y -> acc ++ flatten y) [] lst

-- Calculates how much space can we gain by deleting all directories of at most size a
deleteSize :: Int -> File -> Int
deleteSize size (Directory file rest) = inner + if file < size then file else 0
    where inner = foldl (\acc f -> deleteSize size f + acc) 0 rest

findClosest :: Int -> [Int] -> Int
findClosest a [] = a
findClosest a (h:t) = if a < h then h else findClosest a t

takeUntil :: (a -> Bool) -> [a] -> [a]
takeUntil _ [] = []
takeUntil p (x:xs) = if p x then [] else x : takeUntil p xs

dropUntil :: (a -> Bool) -> [a] -> [a]
dropUntil _ [] = []
dropUntil p (x:xs) = if p x then x:xs else dropUntil p xs

getFileSize :: String -> Int
getFileSize file = let (size:_) = split " " file
                in (read size :: Int)

-- Handles all commands up until '$ cd ..'
parseCommands :: [String] -> ([File], [String])
parseCommands [] = ([], [])
parseCommands (c:t) | "$ cd .." `isPrefixOf` c = ([], t)
                    | Just dir <- stripPrefix "$ cd " c = (innerDir:otherDirs, rest)
                    | otherwise = ([], c:t)
                        where (innerDir, restCommands) = parseDir t
                              (otherDirs, rest) = parseCommands restCommands

parseDir :: [String] -> (File, [String])
-- First command is always 'ls' of the directory, we can safely ignore that
parseDir (_:t) = (directory, rest)
    where files = takeUntil (\x -> head x == '$') t
          fileSize = sum $ map getFileSize $ filter (\(h:_) -> h /= 'd') files
          commands = dropUntil (\x -> head x == '$') t
          (innerDirs, rest) = parseCommands commands
          directory = Directory fileSize innerDirs

main = do
    file <- getContents
    let ([h], _) = parseCommands $ lines file
        sizes = sort $ flatten $ prefixSum h
        total = last sizes
        needed = total + 30000000 - 70000000
    print $ sum $ filter (< 100000) sizes 
    print total
    print needed
    print $ findClosest needed sizes
