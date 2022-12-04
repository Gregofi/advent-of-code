
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

----------------------------------------------------------------------------------

-- From "3-4, 1-2" returns ((1,2), (3,4)). Notice how the pair which has smaller beginning is first.
splitToPairs :: String -> ((Int, Int), (Int, Int))
splitToPairs str = if h11 < h21 then ((h11, h12), (h21, h22)) else ((h21, h22), (h11, h12))
    where [s1, s2] = split "," str
          f = map (read::String->Int) . split "-"
          [h11, h12] = f s1
          [h21, h22] = f s2

isInner :: ((Int, Int), (Int, Int)) -> Bool
isInner ((x1, y1), (x2, y2)) = x1 <= x2 && x2 <= y1


main = do
    content <- getContents
    let lins = lines content
        ranges = sum $ map (fromEnum . isInner . splitToPairs) lins
    print ranges
