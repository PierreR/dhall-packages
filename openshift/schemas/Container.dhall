let openshift = ../packages/openshift.dhall

let Container =
      { Type =
          { name : Text
          , image : Text
          , envVars : List openshift.EnvVar.Type
          , runAsRoot : Bool
          , runPrivileged : Bool
          , ports : List Natural
          , volumeMounts : List openshift.VolumeMount.Type
          }
      , default =
          { runAsRoot = False
          , runPrivileged = False
          , envVars = [] : List openshift.EnvVar.Type
          , volumeMounts = [] : List openshift.VolumeMount.Type
          , ports = [] : List Natural
          }
      }

in  Container
