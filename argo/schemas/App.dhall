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
  { repository = "http://stash.cirb.lan/scm/oc/projects.git"
  , argoPlugin = None Text
  , revision = None Text
  , namespace = None Text
  }
}
