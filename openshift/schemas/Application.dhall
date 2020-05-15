let openshift = ../packages/openshift.dhall

let Deployment = ../schemas/Deployment.dhall

let Service = ../schemas/Service.dhall

let Route = ../schemas/Route.dhall

in  { Type =
        { name : Text
        , domain : Text
        , displayName : Text
        , service : Service.Type
        , route : Route.Type
        , deployment : Deployment.Type
        , enableTLS : Bool
        , volumeClaims : List openshift.PersistentVolumeClaim.Type
        , configMaps : List openshift.ConfigMap.Type
        , secrets : List openshift.Secret.Type
        }
    , default =
      { enableTLS = False
      , domain = ""
      , displayName = ""
      , volumeClaims = [] : List openshift.PersistentVolumeClaim.Type
      , configMaps = [] : List openshift.ConfigMap.Type
      , secrets = [] : List openshift.Secret.Type
      }
    }
