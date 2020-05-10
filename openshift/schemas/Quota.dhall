{ Type =
    { `requests.cpu` : Text
    , `requests.memory` : Text
    , `limits.cpu` : Text
    , `limits.memory` : Text
    }
, default =
  { `requests.cpu` = "1"
  , `requests.memory` = "1Gi"
  , `limits.cpu` = "2"
  , `limits.memory` = "2Gi"
  }
}
