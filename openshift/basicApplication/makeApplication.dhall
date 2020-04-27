let Prelude = ../types/Prelude.dhall

let makeRoute = ./makeRoute.dhall

let makeService = ./makeService.dhall

let makeDeployment = ./makeDeployment.dhall

let Config = ./types/Config.dhall

let OpenShift = ../types/OpenShift.dhall

let makeApplication =
        λ(config : Config.Type)
      → let configuredService = makeService config

        let configuredRoute = makeRoute config

        let configuredDeployment = makeDeployment config

        in  OpenShift.List::{
            , items =
                  [ OpenShift.Resource.Service configuredService
                  , OpenShift.Resource.Route configuredRoute
                  , OpenShift.Resource.Deployment configuredDeployment
                  ]
                # Prelude.map
                    OpenShift.PersistentVolumeClaim.Type
                    OpenShift.Resource
                    (   λ(volumeClaim : OpenShift.PersistentVolumeClaim.Type)
                      → OpenShift.Resource.PersistentVolumeClaim volumeClaim
                    )
                    config.volumeClaims
                # Prelude.map
                    OpenShift.ConfigMap.Type
                    OpenShift.Resource
                    (   λ(configMap : OpenShift.ConfigMap.Type)
                      → OpenShift.Resource.ConfigMap configMap
                    )
                    config.configMaps
                # Prelude.map
                    OpenShift.Secret.Type
                    OpenShift.Resource
                    (   λ(secret : OpenShift.Secret.Type)
                      → OpenShift.Resource.Secret secret
                    )
                    config.secrets
            }

in  makeApplication
