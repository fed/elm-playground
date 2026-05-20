module Utils exposing (..)


greet : String -> Int -> String
greet name age =
    "Hi! I'm " ++ name ++ " and I'm " ++ String.fromInt age ++ " years old."
