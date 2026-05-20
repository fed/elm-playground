module Avatar exposing (avatar)

import Html exposing (..)
import Html.Attributes exposing (..)


type alias User =
    { login : String
    , name : Maybe String
    , bio : Maybe String
    , location : Maybe String
    , blog : Maybe String
    , avatar_url : Maybe String
    , html_url : String
    }


avatar : User -> Html msg
avatar user =
    div []
        [ h1 [] [ text (Maybe.withDefault "" user.name) ]
        , p [] [ text user.login ]
        , img
            [ class "avatar"
            , src (Maybe.withDefault "" user.avatar_url)
            , alt ("Photo of " ++ Maybe.withDefault "" user.name)
            ]
            []
        ]
