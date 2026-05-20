module Main exposing (main)

import Browser
import Html exposing (..)
import UserProfileApp


main : Program () UserProfileApp.Model UserProfileApp.Msg
main =
    Browser.element
        { init = UserProfileApp.init
        , update = UserProfileApp.update
        , subscriptions = \_ -> Sub.none
        , view = UserProfileApp.view
        }
