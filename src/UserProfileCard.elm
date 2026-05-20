module UserProfileCard exposing (User, view)

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
    , followers : Int
    }


view : User -> Html msg
view user =
    div [ class "flex flex-col items-center text-center space-y-4" ]
        [ div [ class "relative group" ]
            [ img
                [ class "relative w-32 h-32 rounded-full border-2 border-slate-800 object-cover shadow-2xl transition-transform duration-300 group-hover:scale-105"
                , src (Maybe.withDefault "" user.avatar_url)
                , alt ("Photo of " ++ Maybe.withDefault "" user.name)
                ]
                []
            ]
        , div []
            [ h1 [ class "text-3xl font-extrabold tracking-tight bg-gradient-to-r from-emerald-400 to-amber-400 bg-clip-text text-transparent" ]
                [ text (Maybe.withDefault "" user.name) ]
            , p [ class "text-amber-400 font-mono text-sm tracking-wide mt-1" ]
                [ text ("@" ++ user.login) ]
            ]
        ]
