inc :: Int -> Int     -- type signature
inc x = x + 1         -- function equation

-- inc 3 == 4

exclaim :: String -> String
exclaim sentence = sentence ++ "!"

-- exclaim "Hola" == "Hola!"

average :: Float -> Float -> Float
average a b = (a + b) / 2

-- average 7 5 == 6

largo :: [a] -> Int
largo [] = 0
largo (x:xs) = 1 + largo xs

-- largo [1,2,3,4,5] == 5

numeros = [1..]

-- take 10 numeros == [1,2,3,4,5,6,7,8,9,10]

factorial :: Integer -> Integer
factorial 0 = 1
factorial n = n * factorial (n-1)

-- factorial 5 == 120

fact n =
  if n == 0
  then 1
  else n * fact (n-1)

qsort::(Ord a) => [a] -> [a]
qsort [] = []
qsort (x:xs) =
  (qsort menores) ++ (x : (qsort mayores))
  where
    menores = [y | y <- xs, y <= x]
    mayores = [y | y <- xs, y > x]

-- qsort [7,1,6,3,2,5,0,8,4] == [0,1,2,3,4,5,6,7,8]

data Arbol a = Hoja a | Rama (Arbol a) (Arbol a)

arbol2lista:: (Arbol a) -> [a]
arbol2lista (Hoja a) = [a]
arbol2lista (Rama izq der) = (arbol2lista izq) ++ (arbol2lista der)

-- arbol2lista (Rama (Hoja "hola") (Rama (Hoja "que") (Hoja "tal?"))
--    == ["hola", "que", "tal?"]

primos = 
  sieva [2..]
  where
    sieva (x:xs) = x : sieva [y | y <- xs, y `mod` x /= 0] 
    
-- take 10 primos == [2,3,5,7,11,13,17,19,23,29,31]

