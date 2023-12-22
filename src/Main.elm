module Main exposing (..)

import Html exposing (Html)
import Html.Events as HE
import Browser
import Debug.Extra

type alias Flags =
    ()


type alias Model =
    { toggled : Bool
    }


type Msg
    = ClickedToggle


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( { toggled = False }
    , Cmd.none
    )


view : Model -> Html Msg
view model =
    let
        _ =
            -- Start a timer
            Debug.Extra.time "vdom construction time" ()
    in
    Html.div
        []
        [ Html.p
            []
            [ Html.text "Open your DevTools console or start a performance timeline before clicking the button"
            ]
        , Html.button
            [ HE.onClick ClickedToggle
            ]
            [ Html.text "Click me to trigger a re-render"
            ]
        ]
            |> Debug.Extra.performanceMark "blocking for 100ms"
            |> Debug.Extra.block 100
            |> Debug.Extra.performanceMark "blocking for 200ms"
            |> Debug.Extra.block 200
            -- Report the total elapsed time of "vdom construction time"
            |> Debug.Extra.timeEnd "vdom construction time"



update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        ClickedToggle ->
            ( { model | toggled = not model.toggled }
            , Cmd.none
            )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }