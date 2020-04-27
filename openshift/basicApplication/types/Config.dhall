let OpenShift = ../../types/OpenShift.dhall

let Container = ../../types/Container.dhall

in  { Type =
        { name : Text
        , domain : Text
        , displayName : Text
        , replicas : Natural
        , enableTLS : Bool
        , port : Natural
        , timeout : Text
        , volumes : List OpenShift.Volume.Type
        , volumeClaims : List OpenShift.PersistentVolumeClaim.Type
        , configMaps : List OpenShift.ConfigMap.Type
        , secrets : List OpenShift.Secret.Type
        , containers : List Container.Type
        }
    , default =
        { enableTLS = False
        , domain = ""
        , displayName = ""
        , replicas = 1
        , timeout = "60s"
        , volumes = [] : List OpenShift.Volume.Type
        , volumeClaims = [] : List OpenShift.PersistentVolumeClaim.Type
        , configMaps = [] : List OpenShift.ConfigMap.Type
        , secrets = [] : List OpenShift.Secret.Type
        }
    }
