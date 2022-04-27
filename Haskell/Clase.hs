module Clase where
    cabeza :: [a] -> Maybe a
    cabeza [] = Nothing
    cabeza (x:_) = Just x

    cola :: [a] -> Maybe [a]
    cola [] = Nothing
    cola (_:xs) = Just xs

    dobleCola lista =
        case (cola lista) of
            Nothing -> Nothing
            Just xs -> cola xs

    otraDobleCola lista =
        do 
            a <- cola lista
            b <- cola a
            return b

    tercerDobleCola lista =
        do {
            a <- cola lista; -- pareciera codico
            b <- cola a;     -- imperativo
            return b         -- pero realmente esta usando >>= entre cada linea
        }

    -- Este era el ejemplo que queria hacer
    -- pueden probar
    -- cola []
    -- cola [] >>= cola
    -- cola [] >>= cola >>= cola >>= cola
    -- dobleCola []
    -- otraDobleCola []
    -- dobleCola [1,2,3]
