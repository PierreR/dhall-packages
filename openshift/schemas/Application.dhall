let openshift = ../packages/openshift.dhall

let Container = ../schemas/Container.dhall

in  { Type =
        { name : Text
        , domain : Text
        , displayName : Text
        , replicas : Natural
        , enableTLS : Bool
        , port : Natural
        , timeout : Text
        , volumes : List openshift.Volume.Type
        , volumeClaims : List openshift.PersistentVolumeClaim.Type
        , configMaps : List openshift.ConfigMap.Type
        , secrets : List openshift.Secret.Type
        , containers : List Container.Type
        }
    , default =
        { enableTLS = False
        , domain = ""
        , displayName = ""
        , replicas = 1
        , timeout = "60s"
        , volumes = [] : List openshift.Volume.Type
        , volumeClaims = [] : List openshift.PersistentVolumeClaim.Type
        , configMaps = [] : List openshift.ConfigMap.Type
        , secrets = [] : List openshift.Secret.Type
        }
    }
