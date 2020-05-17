let openshift = ../packages/openshift.dhall

let Container =
      { Type =
          { name : Text
          , image : Text
          , envVars : Optional (List openshift.EnvVar.Type)
          , runAsRoot : Bool
          , runPrivileged : Bool
          , ports : Optional (List Natural)
          , volumeMounts : Optional (List openshift.VolumeMount.Type)
          }
      , default =
        { runAsRoot = False
        , runPrivileged = False
        , envVars = None (List openshift.EnvVar.Type)
        , volumeMounts = None (List openshift.VolumeMount.Type)
        , ports = None (List Natural)
        }
      }

in  Container
