-- Minimal resources built from an 'application-form'
let Quota = ../schemas/Quota.dhall

let Project = ../schemas/Project.dhall

let Deployment = ../schemas/Deployment.dhall

let Service = ../schemas/Service.dhall

let Route = ../schemas/Route.dhall

in  { Type =
        { project : Project
        , deployment : Optional Deployment.Type
        , service : Optional Service.Type
        , route : Optional Route.Type
        , quota : Quota.Type
        , enableTLS : Bool
        }
    , default =
      { quota = Quota.default
      , deployment = None Deployment.Type
      , service = None Service.Type
      , route = None Route.Type
      , enableTLS = False
      }
    }
