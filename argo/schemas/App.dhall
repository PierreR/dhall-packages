{ Type =
    { project : Text
    , name : Text
    , path : Text
    , repository : Text
    , argoPlugin : Optional Text
    }
, default = { project = "default", argoPlugin = None Text, path = "./" }
}
