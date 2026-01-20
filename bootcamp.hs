sho :: a -> a
sho x = x

add :: Int -> Int -> Int
add x y = x + y

circle :: Float -> Float
circle r = 3.14 * r * r

diva a b
  | b == 0 = 0
  | otherwise = a / b

checkSpeed u
  | u > 100 = "High speed"
  | u < 20 = "Low speed"
  | True = "Perfect"
