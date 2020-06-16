{ Type =
    { project : Text
    , name : Text
    , path : Text
    , repository : Text
    , argoPlugin : Optional Text
    , revision : Optional Text
    , namespace : Optional Text
    }
, default =
  { project = "default"
  , argoPlugin = None Text
  , path = "./"
  , revision = None Text
  , namespace = None Text
  }
}
