prefix :: String -> String -> Bool
prefix [] _ = True
prefix _ [] = False
prefix (h1:t1) (h2:t2)
    | h1 == h2 = prefix t1 t2
    | otherwise = False


remove_prefix :: String -> String -> String
remove_prefix [] s = s
remove_prefix _ [] = []
remove_prefix (h1:t1) (h2:t2)
    | h1 == h2 = remove_prefix t1 t2
    | otherwise = h2:t2


split :: String -> String -> [String]
split _ [] = []
split delim str | (prefix delim str) = []:(split delim (remove_prefix delim str))
split delim (h:t) = let head:tail = split delim t
                    in (h:head):tail


main = do
    content <- getContents
    let str_lst = split "\n\n" content
        str_lss = split "\n" $ head str_lst
    print str_lss
