let typesUnion = ./typesUnion.dhall

let project = ./project.dhall

let route = ./route.dhall

let service = ./service.dhall

let Config = ./config.dhall

let OpenShiftList = ./list.dhall

let createApplication =
        λ(config : Config.Type)
      → let configuredService = service config

        let configuredRoute = route config

        let configuredProject = project config

        in  OpenShiftList::{
            , items =
              [ typesUnion.Project configuredProject
              , typesUnion.Service configuredService
              , typesUnion.Route configuredRoute
              ]
            }

in  createApplication
