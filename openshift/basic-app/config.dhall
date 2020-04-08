let OpenShift =
      ./openshift.dhall sha256:422477ee4999e20e3aa0486f9b25c5728e7e266d42b143b53578eff44e92f009

in  { Type =
        { name : Text
        , appPort : Natural
        , image : Text
        , domain : Text
        , displayName : Text
        , replicas : Natural
        , envVars : List OpenShift.EnvVar.Type
        , enableTLS : Bool
        , timeout : Text
        }
    , default =
        { name = ""
        , appPort = 9999
        , enableTLS = False
        , image = ""
        , domain = ""
        , displayName = ""
        , replicas = 1
        , envVars = [] : List OpenShift.EnvVar.Type
        , timeout = "60s"
        }
    }
