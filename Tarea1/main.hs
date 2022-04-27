--Tarea Programada No.1: Haskell
--Ericka Cespedes Moya 2017239557

--Problema 1
--Elimine todos
--Toma un item (de un tipo que instancia de la clase Eq) y una lista, y devuelve una lista que es la lista original sin el elemento que se dio como referencia
--elimine_todos :: (Eq a) => a -> [a] -> [a]
--1. utilizando comprension de listas
elimine_todos :: (Eq a) => a -> [a] -> [a]
elimine_todos elemento xs = [x | x <-xs, x /= elemento]
--2. solo las funciones definidas en el ambiente inicial de Haskell
elimine_todos_func :: (Eq a) => a -> [a] -> [a]
elimine_todos_func elemento lista = filter (\e -> e/=elemento) lista
--3. utilizando su propia recursividad
elimine_todos_rec :: (Eq a) => a -> [a] -> [a]
elimine_todos_rec _ [] = []
elimine_todos_rec e (x:xs) | e == x = elimine_todos_rec e xs
                    | otherwise = x : elimine_todos_rec e xs

--Problema 2
--Elimine segundo
--Toma un item (de tipo que tiene la funcion == definida) y una lista, y devuelve una lista como la que recibio, pero con la segunda ocurrencia del item, si la hay, removida de la lista.
elimine_segundo :: (Eq a) => a -> ([a] -> [a])
elimine_segundo n [] = []
elimine_segundo n lista = elimineSegundoAux n lista 0

elimineSegundoAux n [] c = []
elimineSegundoAux n lista c = 
    if (n == (head lista))
    then 
        if (c == 0)
            then (head lista) : elimineSegundoAux n (tail lista) (c+1)
        else 
            (tail lista)
    else 
        (head lista) : elimineSegundoAux n (tail lista) c

--Problema 3
--tal que asociado x par da como resultado la lista que contiene los valores que estan asociados con x en la primer lista.
asociado :: (Eq a) => a -> [(a,b)] -> [b]
--1. comprension de listas
asociado e list = [ y | (x,y) <- list, x==e ]
--2. solo las funciones definidas en el ambiente inicial de Haskell
asociado2 :: (Eq a) => a -> [(a,b)] -> [b]
asociado2 n [] = []
asociado2 n listaPares = 
    if n == (fst(head listaPares))
    then (snd(head listaPares)) : asociado2 n (tail listaPares)
    else asociado2 n (tail listaPares)

--Problema 4
--Aqu´ı exploramos un poco el algoritmo de Newton Rapson, considere el siguiente c´odigo
prox :: (Real a, Fractional a) => a -> a -> a
prox n x = (x + n / x) / 2
--1. utilizando la function iterate de Haskell escriba una funci´on
aproximaciones :: (Real a, Fractional a) => a -> a -> [a]
aproximaciones n a0 = newton sin cos n
newton f f' x0 = iterate next x0
    where next xn = xn - ((f xn) / (f' xn))
--tal que approximations n a0 retorna una lista infinita de aproximaciones a la ra´ız cuadrada de n, empezando del valor a0. Por ejemplo:

--PROBLEMA 5
diff :: (Real a, Fractional a) => (a -> a) -> a -> a -> a
diff f x delta = (f(x + delta) - f(x)) / delta

difAprox :: (Real a, Fractional a) => a -> (a -> a) -> a -> [a]
difAprox delta f x = 
    diff f x delta : difAprox (delta/2) f x

--PROBLEMA 6
derive :: (Real a, Fractional a) => a -> a -> (a -> a) -> a -> a
derive ep delta f x = 
    entre ep (difAprox delta f x)

--PROBLEMA 7
componga :: [(a -> a)] -> (a -> a)
componga [] = (\f -> f)
componga lista = 
    (head lista).componga (tail lista)

--PROBLEMA 8
merge :: (Ord a) => [[a]] -> [a]
merge [] = []
merge lista = quickSort((head lista) ++ merge(tail lista))

quickSort :: (Ord a) => [a] -> [a]
quickSort [] = []
quickSort (x:xs) = quickSort [y | y <- xs, y<x] 
                ++ [x] 
                ++ quickSort [y | y <- xs, y>=x]

--PROBLEMA 10
separePorComas :: [String] -> String 
separePorComas [] = ""
separePorComas (x:xs) = 
    x ++ 
    if (xs /= []) 
    then ", " ++ separePorComas(xs)
    else separePorComas(xs)

--PROBLEMA 11
--1. Funciones Prelude
enLineasSeparadas :: [String] -> IO()
enLineasSeparadas lista = putStr(enLineasSeparadas2(lista))
enLineasSeparadas lista = putStr(separadoPor "\n" lista)

--2. Recursividad
enLineasSeparadas2 :: [String] -> String
enLineasSeparadas2 [] = ""
enLineasSeparadas2 lista = 
    (head lista) ++ "\n" ++ enLineasSeparadas2(tail lista)

--PROBLEMA 12
separadoPor :: String -> [String] -> String
separadoPor "" [] = ""
separadoPor string lista =
    if length(tail lista) /= 0
        then (head lista) ++ string ++ (separadoPor string (tail lista))
    else (head lista) ++ "\n" 

--PROBLEMA 14
--1. Comprensión de listas
dupliqueTodo :: [Integer] -> [Integer]
dupliqueTodo [] = []
dupliqueTodo lista = [x*2 | x <- lista]

--2. Utilizando foldr
dupliqueTodo2 :: [Integer] -> [Integer]
dupliqueTodo2 [] = []
dupliqueTodo2 lista = 
    foldr(\x y->x*2:y) [] lista

--PROBLEMA 17
data Set a = Set (a -> Bool)

conjunto :: (a -> Bool) -> (Set a)
conjunto n = Set n

union :: (Set a) -> (Set a) -> (Set a)
union (Set a) (Set b) = Set (\x -> (a x) || (b x))

interseccion :: (Set a) -> (Set a) -> (Set a)
interseccion (Set y) (Set z) = Set (\x -> (y x) && (z x))

miembro :: (Set a) -> a -> Bool
miembro (Set x) y = x y 

complemento :: (Set a) -> (Set a)
complemento (Set a) = Set (\x -> not (a x))