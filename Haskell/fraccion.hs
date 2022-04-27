module Fraccion(
     Fraccion,
     fraccion,
     num
     den) where


data Fraccion = F {
                  num :: Integer,
                  den :: Integer
                }
                
instance Show Fraccion where
  show f = (show (num f))++"/"++(show (den f))

fraccion :: Integer -> Integer -> Fraccion
fraccion _ 0 = error("Division por 0!")
fraccion m n =
  F a b
  where
    c = max (abs m) (abs n)
    d = min (abs m) (abs n)
    b = div (abs n) (mcd c d)
    a = if n < 0
        then div (-m) (mcd c d)
        else div   m  (mcd c d)
    mcd :: Integer -> Integer -> Integer
    mcd n 0 = n
    mcd m n = mcd n (mod m n)

        
instance Num Fraccion where
  a + b = fraccion ((num a)*(den b) + (den a)*(num b)) ((den a)*(den b))
  a - b = fraccion ((num a)*(den b) - (den a)*(num b)) ((den a)*(den b))
  a * b = fraccion ((num a)*(num b)) ((den a)*(den b))
  negate a = F (- (num a)) (den a)
  abs a = F (abs (num a)) (den a)
  signum a | (num a) > 0 = 1
           | (num a) == 0 = 0
           | (num a) < 0 = -1
  fromInteger n = F n 1
  
--
-- fraccion 15 5
-- (fraccion 6 4) + (fraccion 5 4)
--


