module ShoppingList exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import List exposing (map)


products : List { title : String, isFruit : Bool, id : number }
products =
    [ { title = "Cabbage", isFruit = False, id = 1 }
    , { title = "Garlic", isFruit = False, id = 2 }
    , { title = "Apple", isFruit = True, id = 3 }
    ]


shoppingList : Html msg
shoppingList =
    let
        listItems =
            List.map
                (\product ->
                    li
                        [ if product.isFruit then
                            style "color" "magenta"

                          else
                            style "color" "darkgreen"
                        ]
                        [ text product.title ]
                )
                products
    in
    ul [] listItems
