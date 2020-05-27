-- Minimal application

let openshift = ../packages/openshift.dhall

let Deployment = ../schemas/Deployment.dhall

let Secret = ../schemas/Secret.dhall

let Service = ../schemas/Service.dhall

let Route = ../schemas/Route.dhall

in  { Type =
        { namespace : Text
        , deployment : Optional Deployment.Type
        , volumeClaims : Optional (List openshift.PersistentVolumeClaim.Type)
        , volumes : Optional (List openshift.Volume.Type)
        , configMaps : Optional (List openshift.ConfigMap.Type)
        , service : Optional Service.Type
        , route : Optional Route.Type
        , secrets : Optional (List Secret.Type)
        }
    , default =
      { deployment = None Deployment.Type
      , volumeClaims = None (List openshift.PersistentVolumeClaim.Type)
      , volumes = None (List openshift.Volume.Type)
      , configMaps = None (List openshift.ConfigMap.Type)
      , service = None Service.Type
      , route = None Route.Type
      , secrets = None (List Secret.Type)
      }
    }
