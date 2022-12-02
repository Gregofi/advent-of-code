
import Data.Char

-- A = Rock, B = Paper, C = Scissors
-- X = Lose, Y = Tie, Z = Win

getGameScore :: Char -> Integer
getGameScore 'X' = 0
getGameScore 'Y' = 3
getGameScore 'Z' = 6

getPlayScore :: Char -> Integer
getPlayScore 'A' = 1
getPlayScore 'B' = 2
getPlayScore 'C' = 3

getRightChar :: (Char, Char) -> Char
getRightChar ('A', 'X') = 'C'
getRightChar ('B', 'X') = 'A'
getRightChar ('C', 'X') = 'B'
getRightChar ('A', 'Z') = 'B'
getRightChar ('B', 'Z') = 'C'
getRightChar ('C', 'Z') = 'A'
getRightChar (x, 'Y') = x 

getScore = sum . map (\(opponent, play) -> getGameScore play + getPlayScore (getRightChar (opponent, play)))

shift :: Char -> Char
shift c = chr $ ord c - ord 'X' + ord 'A'

main = do
    file <- getContents
    -- parse input into lists of pairs of plays -> [('A', 'X'), ...]
    let pairs = (map ((\(a:b:"") -> (a, b)) . map head . words) . lines) file
    print $ getScore pairs