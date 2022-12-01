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


max' :: Integer -> Integer -> Integer
max' a b | a > b = a | otherwise = b


qsort :: (Ord a) => [a] -> [a]
qsort [] = []
qsort (x:xs) =
    let smaller = filter (>= x) xs
        bigger  = filter (< x) xs
    in qsort smaller ++ [x] ++ qsort bigger

main = do
    content <- getContents
    let work = qsort . map (foldr (+) 0 . map (read::String->Int) . split "\n") . split "\n\n"
        (h1:h2:h3:_) = work content
    print $ h1 + h2 + h3