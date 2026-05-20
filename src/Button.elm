module Button exposing (..)

import Html exposing (..)
import Html.Events exposing (..)



-- INIT


type alias Model =
    Int


init : Model
init =
    0



-- UPDATE


type Msg
    = HandleClick


update : Msg -> Model -> Model
update msg model =
    case msg of
        HandleClick ->
            model + 1



-- VIEW


view : Model -> Html Msg
view model =
    button
        [ onClick HandleClick ]
        [ text ("Clicked " ++ String.fromInt model ++ " times")
        ]
