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

fromList :: (Ord a) => [a] -> BinaryTree a
fromList [] = Leaf
fromList (h:t) = insert (fromList t) h

inorder :: (Ord a) => BinaryTree a -> [a]
inorder Leaf = []
inorder (Node left root right) = inorder left ++ [root] ++ inorder right

split :: [a] -> ([a], [a])
split lst = splitAt n lst
            where n = div (length lst) 2

findCommon :: (Ord a) => BinaryTree a -> [a] -> BinaryTree a
findCommon tree [] = Leaf
findCommon tree (h:t)
    | contains tree h = insert (findCommon tree t) h
    | otherwise = findCommon tree t

charToPoints :: Char -> Int
charToPoints c
    | ord c <= ord 'Z' = (ord c - ord 'A') + (ord 'Z' - ord 'A') + 2
    | otherwise = ord c - ord 'a' + 1

findResult :: (Ord a) => ([a], [a], [a]) -> [a]
findResult (lst1, lst2, lst3) = inorder $ findCommon (findCommon tree1 lst3) lst2
    where tree1 = fromList lst1

partition :: [[a]] -> [([a],[a],[a])]
partition [] = []
partition (h1:h2:h3:t) = (h1, h2, h3) : partition t

main = do
    input <- getContents
    let res = sum $ concatMap findResult (partition $ map (map charToPoints) $ lines input)
    print res