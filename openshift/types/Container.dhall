let OpenShift =
      ./openshift.dhall sha256:422477ee4999e20e3aa0486f9b25c5728e7e266d42b143b53578eff44e92f009

let Container =
      { Type =
          { name : Text
          , image : Text
          , envVars : List OpenShift.EnvVar.Type
          , runAsRoot : Bool
          , runPrivileged : Bool
          , ports : List Natural
          , volumeMounts : List OpenShift.VolumeMount.Type
          }
      , default =
          { runAsRoot = False
          , runPrivileged = False
          , envVars = [] : List OpenShift.EnvVar.Type
          , volumeMounts = [] : List OpenShift.VolumeMount.Type
          , ports = [] : List Natural
          }
      }

in  Container
