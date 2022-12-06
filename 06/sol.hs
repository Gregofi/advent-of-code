import qualified Data.Set as Set

findIdx :: Ord a => Int -> [a] -> Int
findIdx _ [] = 0
findIdx n (h:t) = if n == Set.size (Set.fromList $ take n (h:t))
                    then n
                    else findIdx n t + 1

main = do
    str <- getContents
    print $ findIdx 14 str
