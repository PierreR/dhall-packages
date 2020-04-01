{ Type =
    { name : Text
    , appPort : Natural
    , image : Text
    , domain : Text
    , displayName : Text
    , replicas : Natural
    }
, default =
    { name = ""
    , appPort = 9999
    , image = ""
    , domain = ""
    , displayName = ""
    , replicas = 1
    }
}
