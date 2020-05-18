-- Minimal application built from an 'application-form'

let openshift = ../packages/openshift.dhall

let Quota = ../schemas/Quota.dhall

let Project = ../schemas/Project.dhall

let Deployment = ../schemas/Deployment.dhall

let Secret = ../schemas/Secret.dhall

let Service = ../schemas/Service.dhall

let Route = ../schemas/Route.dhall

in  { Type =
        { project : Project
        , quota : Quota.Type
        , deployment : Optional Deployment.Type
        , volumeClaims : Optional (List openshift.PersistentVolumeClaim.Type)
        , configMaps : Optional (List openshift.ConfigMap.Type)
        , service : Optional Service.Type
        , route : Optional Route.Type
        , secrets : Optional (List Secret.Type)
        , enableTLS : Bool
        }
    , default =
      { quota = Quota.default
      , deployment = None Deployment.Type
      , volumeClaims = None (List openshift.PersistentVolumeClaim.Type)
      , configMaps = None (List openshift.ConfigMap.Type)
      , service = None Service.Type
      , route = None Route.Type
      , secrets = None (List Secret.Type)
      , enableTLS = False
      }
    }
