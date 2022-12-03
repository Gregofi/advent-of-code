import Data.Char

data BinaryTree a = Leaf | Node (BinaryTree a) a (BinaryTree a)

insert :: (Ord a) => BinaryTree a -> a -> BinaryTree a
insert Leaf v = Node Leaf v Leaf
insert (Node left root right) val
    | root < val = Node left root (insert right val)
    | root > val = Node (insert left val) root right
    | otherwise  = Node left root right

contains :: (Ord a) => BinaryTree a -> a -> Bool
contains Leaf v = False
contains (Node left root right) val
    | root > val = contains left val
    | root < val = contains right val
    | otherwise  = True

split :: [a] -> ([a], [a])
split lst = splitAt n lst
            where n = div (length lst) 2

fromString :: String -> BinaryTree Char
fromString "" = Leaf
fromString (h:t) = insert (fromString t) h

findCommon :: BinaryTree Char -> String -> Char
findCommon tree (h:t)
    | contains tree h = h
    | otherwise = findCommon tree t

charToPoints :: Char -> Int
charToPoints c
    | ord c <= ord 'Z' = (ord c - ord 'A') + (ord 'Z' - ord 'A') + 2
    | otherwise = ord c - ord 'a' + 1

findResult :: (String, String) -> Int
findResult (first, second) = charToPoints $ findCommon (fromString first) second

main = do
    input <- getContents
    let res = sum $ map (findResult . split) (lines input)
    print res