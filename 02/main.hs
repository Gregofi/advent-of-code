import Data.Char

-- A = Rock, B = Paper, C = Scissors

getPlayScore :: Char -> Integer
getPlayScore 'A' = 1
getPlayScore 'B' = 2
getPlayScore 'C' = 3

getWinScore :: (Char, Char) -> Integer
getWinScore (x, y) 
    | x == y = 3
    | (x == 'C' && y == 'A') || (x == 'A' && y == 'B') || (x == 'B' && y == 'C') = 6
    | otherwise = 0

getScore = sum . map (\(opponent, me) -> getPlayScore me + getWinScore (opponent, me))

shift :: Char -> Char
shift c = chr $ ord c - ord 'X' + ord 'A'

main = do
    file <- getContents
    let pairs = (map ((\(a:b:"") -> (a, shift b)) . map head . words) . lines) file
    print $ getScore pairs