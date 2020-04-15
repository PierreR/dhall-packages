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
        , runAsRoot : Bool
        , runPrivileged : Bool
        , timeout : Text
        , volumes : List OpenShift.Volume.Type
        , volumeMounts : List OpenShift.VolumeMount.Type
        , volumeClaims : List OpenShift.PersistentVolumeClaim.Type
        }
    , default =
        { name = ""
        , appPort = 9999
        , enableTLS = False
        , image = ""
        , domain = ""
        , displayName = ""
        , replicas = 1
        , runAsRoot = False
        , runPrivileged = False
        , envVars = [] : List OpenShift.EnvVar.Type
        , timeout = "60s"
        , volumes = [] : List OpenShift.Volume.Type
        , volumeMounts = [] : List OpenShift.VolumeMount.Type
        , volumeClaims = [] : List OpenShift.PersistentVolumeClaim.Type
        }
    }
