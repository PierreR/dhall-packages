let typesUnion = ./typesUnion.dhall

let route = ./route.dhall

let service = ./service.dhall

let deployment = ./deployment.dhall

let Config = ./config.dhall

let OpenShiftList = ./list.dhall

let createApplication =
        λ(config : Config.Type)
      → let configuredService = service config

        let configuredRoute = route config

        let configuredDeployment = deployment config

        in  OpenShiftList::{
            , items =
              [ typesUnion.Service configuredService
              , typesUnion.Route configuredRoute
              , typesUnion.Deployment configuredDeployment
              ]
            }

in  createApplication
