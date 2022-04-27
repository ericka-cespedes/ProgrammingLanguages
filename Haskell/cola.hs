module Cola(Arbol,Cola,digit2bool,number2bool,insertQ,delQ,firstQ) where

data Arbol a = Hoja | Nodo a (Arbol a) (Arbol a) deriving Show
data Cola    = Queue Int (Arbol Int) deriving Show

emptyQ = Queue 0 Hoja

digit2bool :: Int -> Bool
digit2bool 0 = False
digit2bool 1 = True

number2bool :: Int -> [Bool]
number2bool n = num2bool n []
      where
         num2bool 0 l = l
         num2bool n l = num2bool (div n 2) (digit2bool (mod n 2):l)

checkUp :: (Arbol Int) -> (Arbol Int)
checkUp (Nodo x Hoja Hoja) = Nodo x Hoja Hoja
checkUp (Nodo x (Nodo y a b) Hoja) =
   if x < y
   then Nodo x (Nodo y a b) Hoja
   else Nodo y (Nodo x a b) Hoja
checkUp (Nodo x (Nodo y a b) (Nodo z c d)) 
    | (x <= y) && (x <= z) = Nodo x (Nodo y a b) (Nodo z c d)
    | (y <= x) && (y <= z) = Nodo y (Nodo x a b) (Nodo z c d)
    | (z <= x) && (z <= y) = Nodo z( Nodo y a b) (Nodo x c d)

checkDown :: (Arbol Int) -> (Arbol Int)
checkDown (Nodo x Hoja Hoja) = Nodo x Hoja Hoja
checkDown (Nodo x (Nodo y a b) Hoja) =
   if x < y
   then Nodo x (Nodo y a b) Hoja
   else Nodo y (Nodo x a b) Hoja
checkDown (Nodo x (Nodo y a b) (Nodo z c d))
    | (x <= y) && (x <= z) = Nodo x (Nodo y a b) (Nodo z c d)
    | (y <= x) && (y <= z) = Nodo y (checkDown (Nodo x a b)) (Nodo z c d)
    | (z <= x) && (z <= y) = Nodo z( Nodo y a b) (checkDown (Nodo x c d))

insertQ :: Int -> Cola -> Cola
insertQ x (Queue n a) =
   Queue (n+1) (insertArbol x (tail (number2bool (n+1))) a)
   where
      insertArbol x [] Hoja = Nodo x Hoja Hoja
      insertArbol x (False:ruta) (Nodo y izq der) = checkUp (Nodo y (insertArbol x ruta izq) der)
      insertArbol x (True:ruta)  (Nodo y izq der) = checkUp (Nodo y izq (insertArbol x ruta der))

delQ :: Cola -> Cola

delQ (Queue n a) 
    | n > 0 = Queue (n-1) a'
    where
       (Nodo _ izq der, x) = elimine (tail (number2bool n)) a
       a' = checkDown (Nodo x izq der)
       elimine [] (Nodo x _ _) = (Hoja, x)
       elimine (True:rest) (Nodo a izq der) =
               let
                 (der', x) = elimine rest der
               in
                 (Nodo a izq der', x)
       elimine (False:rest) (Nodo a izq der) =
               let
                 (izq', x) = elimine rest izq
               in
                 (Nodo a izq' der, x)
                 
firstQ :: Cola -> Int
firstQ (Queue _ (Nodo x _ _)) = x

