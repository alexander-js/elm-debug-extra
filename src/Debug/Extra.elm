module Debug.Extra
    exposing
        ( time
        , timeEnd
        , performanceMark
        , debugger
        , block
        )

import Json.Encode as Encode
import Json.Decode as Decode


{-| Start a timer with the given name. This will be logged to the console and shown in performance timelines. See https://developer.mozilla.org/en-US/docs/Web/API/console/time_static -}
time : String -> a -> a
time timerName =
    accessObjectPrototype [ "__elm_debug_extra__", "time", timerName ]


{-| Stop a timer by name. This will be logged to the console and shown in performance timelines. See https://developer.mozilla.org/en-US/docs/Web/API/console/timeend_static -}
timeEnd : String -> a -> a
timeEnd timerName =
    accessObjectPrototype [ "__elm_debug_extra__", "timeEnd", timerName ]


{-| Create a mark to be shown in performance timelines. See https://developer.mozilla.org/en-US/docs/Web/API/Performance/mark -}
performanceMark : String -> a -> a
performanceMark name =
    accessObjectPrototype [ "__elm_debug_extra__", "performanceMark", name ]


{-| Start the debugger in DevTools. Usage should be rare. See https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/debugger -}
debugger : a -> a
debugger =
    accessObjectPrototype [ "__elm_debug_extra__", "debugger" ]


{-| Block the event loop for (approximately) X milliseconds -}
block : Float -> a -> a
block duration =
    accessObjectPrototype [ "__elm_debug_extra__", "block", String.fromFloat duration ]


-- Internal


accessObjectPrototype : List String -> a -> a
accessObjectPrototype path whatever =
    case Decode.decodeValue (Decode.at path (Decode.succeed ())) (Encode.object []) of
        _ ->
            whatever
