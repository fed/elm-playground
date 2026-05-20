module UserProfileApp exposing (Model, Msg, init, update, view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Http
import Json.Decode as Decode exposing (Decoder, field, int, maybe, string)
import UserProfileCard exposing (User)


-- MODEL


type ProfileState
    = Loading
    | Failure Http.Error
    | Success User


type alias Model =
    { profile : ProfileState
    , isFollowing : Bool
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { profile = Loading
      , isFollowing = False
      }
    , fetchGithubProfile "fed"
    )



-- HTTP FETCH & DECODERS


fetchGithubProfile : String -> Cmd Msg
fetchGithubProfile username =
    Http.get
        { url = "https://api.github.com/users/" ++ username
        , expect = Http.expectJson GotProfile userDecoder
        }


userDecoder : Decoder User
userDecoder =
    Decode.map8 User
        (field "login" string)
        (maybe (field "name" string))
        (maybe (field "bio" string))
        (maybe (field "location" string))
        (maybe (field "blog" string))
        (maybe (field "avatar_url" string))
        (field "html_url" string)
        (field "followers" int)



-- UPDATE


type Msg
    = ToggleFollow
    | GotProfile (Result Http.Error User)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ToggleFollow ->
            ( { model | isFollowing = not model.isFollowing }, Cmd.none )

        GotProfile result ->
            case result of
                Ok user ->
                    ( { model | profile = Success user }, Cmd.none )

                Err err ->
                    ( { model | profile = Failure err }, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "max-w-md w-full mx-auto bg-slate-900/60 backdrop-blur-xl border border-slate-800/80 rounded-3xl p-8 shadow-2xl text-slate-100 transition-all duration-300 hover:shadow-emerald-500/10" ]
        [ h2 [ class "text-xs font-semibold uppercase tracking-widest text-slate-500 mb-6 text-center" ]
            [ text "GitHub User Profile" ]
        , case model.profile of
            Loading ->
                div [ class "flex flex-col items-center justify-center py-12 space-y-4" ]
                    [ div [ class "w-10 h-10 border-4 border-emerald-500/20 border-t-emerald-500 rounded-full animate-spin" ] []
                    , div [ class "text-sm text-slate-400 font-medium animate-pulse" ] [ text "Fetching profile from GitHub..." ]
                    ]

            Failure err ->
                div [ class "bg-rose-950/30 border border-rose-800/50 rounded-2xl p-6 text-center space-y-3" ]
                    [ div [ class "inline-flex p-3 bg-rose-500/10 text-rose-500 rounded-full mb-2" ]
                        [ text "⚠️" ]
                    , h3 [ class "text-rose-400 font-bold" ] [ text "Failed to Load Profile" ]
                    , p [ class "text-xs text-slate-400 font-normal leading-relaxed break-words" ]
                        [ text (httpErrorToString err) ]
                    ]

            Success user ->
                let
                    displayFollowers =
                        if model.isFollowing then
                            user.followers + 1

                        else
                            user.followers
                in
                div [ class "space-y-6" ]
                    [ UserProfileCard.view user
                    , div [ class "text-center text-slate-300 text-sm leading-relaxed max-w-xs mx-auto border-t border-slate-800/80 pt-6" ]
                        [ p [] [ text (Maybe.withDefault "No bio available." user.bio) ]
                        ]

                    -- Stats section showing Followers and Location
                    , div [ class "grid grid-cols-2 gap-4 bg-slate-950/40 border border-slate-800/50 rounded-2xl p-4 text-center text-sm font-medium" ]
                        [ div [ class "border-r border-slate-800/80" ]
                            [ div [ class "text-xl font-bold text-slate-100 font-mono tracking-tight" ]
                                [ text (String.fromInt displayFollowers) ]
                            , div [ class "text-[10px] text-slate-500 font-bold uppercase tracking-wider mt-1" ] [ text "Followers" ]
                            ]
                        , div []
                            [ div [ class "text-base font-bold text-slate-100 truncate px-2" ]
                                [ text (Maybe.withDefault "Unknown" user.location) ]
                            , div [ class "text-[10px] text-slate-500 font-bold uppercase tracking-wider mt-1.5" ] [ text "Location" ]
                            ]
                        ]

                    -- Details Section
                    , div [ class "bg-slate-950/40 border border-slate-800/50 rounded-2xl p-4 space-y-3 text-sm font-medium" ]
                        [ div [ class "flex justify-between items-center" ]
                            [ span [ class "text-slate-500" ] [ text "Blog" ]
                            , case user.blog of
                                Just "" ->
                                    span [ class "text-slate-500 italic" ] [ text "None" ]

                                Just url ->
                                    a [ class "text-amber-400 hover:text-amber-300 transition-colors hover:underline truncate max-w-[200px]", href url, target "_blank" ] [ text url ]

                                Nothing ->
                                    span [ class "text-slate-500 italic" ] [ text "None" ]
                            ]
                        , div [ class "flex justify-between items-center" ]
                            [ span [ class "text-slate-500" ] [ text "GitHub Link" ]
                            , a [ class "inline-flex items-center text-emerald-400 hover:text-emerald-300 transition-colors font-mono hover:underline", href user.html_url, target "_blank" ]
                                [ text ("github.com/" ++ user.login) ]
                            ]
                        ]

                    -- Interactive Follow Button
                    , div [ class "flex flex-col items-center space-y-3 border-t border-slate-800/80 pt-6" ]
                        [ button
                            [ class
                                 (if model.isFollowing then
                                    "w-full py-3.5 px-6 rounded-2xl border border-slate-700/80 bg-slate-800/40 hover:bg-rose-950/20 hover:border-rose-900/50 hover:text-rose-400 text-slate-300 font-bold tracking-wide transition-all duration-300 active:scale-[0.98] cursor-pointer"

                                 else
                                    "w-full py-3.5 px-6 rounded-2xl bg-emerald-600 hover:bg-emerald-500 text-white font-bold tracking-wide shadow-lg shadow-emerald-600/20 hover:shadow-emerald-600/30 transition-all duration-300 hover:-translate-y-0.5 active:translate-y-0 active:scale-[0.98] cursor-pointer"
                                )
                            , onClick ToggleFollow
                            ]
                            [ text
                                (if model.isFollowing then
                                    "✓ Following"

                                 else
                                    "Follow"
                                )
                            ]
                        ]
                    ]
        ]


httpErrorToString : Http.Error -> String
httpErrorToString err =
    case err of
        Http.BadUrl url ->
            "Bad URL: " ++ url

        Http.Timeout ->
            "The request timed out."

        Http.NetworkError ->
            "Network error (please check your connection or check if GitHub API is blocked)."

        Http.BadStatus status ->
            "GitHub API returned status code: " ++ String.fromInt status

        Http.BadBody message ->
            "Failed to parse JSON: " ++ message
