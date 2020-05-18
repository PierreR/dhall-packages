{ Type =
    { apiVersion : Text
    , timeout : Text
    , domain : Text
    , path : Optional Text
    , enableTLS : Bool
    }
, default =
  { apiVersion = "route.openshift.io/v1"
  , timeout = "60s"
  , path = None Text
  , enableTLS = False
  }
}
