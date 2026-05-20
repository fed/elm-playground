module Counter exposing (..)

import Browser
import Html exposing (Html, button, div, p, strong, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Utils exposing (greet)



-----------------------------------------------------------
-- MAIN
-----------------------------------------------------------


main =
    Browser.sandbox { init = init, update = update, view = view }



-----------------------------------------------------------
-- MODEL
-----------------------------------------------------------


type alias Model =
    Int


init : Model
init =
    0



-----------------------------------------------------------
-- UPDATE
-----------------------------------------------------------


type Msg
    = Increment
    | Decrement


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            model + 1

        Decrement ->
            model - 1



-----------------------------------------------------------
-- VIEW
-----------------------------------------------------------


view : Model -> Html Msg
view model =
    div []
        [ button [ class "asd", onClick Decrement ] [ text "-" ]
        , div [] [ text (String.fromInt model) ]
        , button [ onClick Increment ] [ text "+" ]
        ]
