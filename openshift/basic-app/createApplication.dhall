let map = ./map.dhall

let typesUnion = ./typesUnion.dhall

let route = ./route.dhall

let service = ./service.dhall

let deployment = ./deployment.dhall

let Config = ./config.dhall

let OpenShiftList = ./list.dhall

let OpenShift =
      ./openshift.dhall sha256:422477ee4999e20e3aa0486f9b25c5728e7e266d42b143b53578eff44e92f009

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
                # map
                    OpenShift.PersistentVolumeClaim.Type
                    typesUnion
                    (   λ(volumeClaim : OpenShift.PersistentVolumeClaim.Type)
                      → typesUnion.PersistentVolumeClaim volumeClaim
                    )
                    config.volumeClaims
                # map
                    OpenShift.ConfigMap.Type
                    typesUnion
                    (   λ(configMap : OpenShift.ConfigMap.Type)
                      → typesUnion.ConfigMap configMap
                    )
                    config.configMaps
            }

in  createApplication
