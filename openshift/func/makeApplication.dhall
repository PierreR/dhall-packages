let Prelude = ../Prelude.dhall

let makeRoute = ./makeRoute.dhall

let makeService = ./makeService.dhall

let makeDeployment = ./makeDeployment.dhall

let Config = ../schemas/Application.dhall

let openshift = ../packages/openshift.dhall

let makeApplication =
        λ(config : Config.Type)
      → let configuredService = makeService config

        let configuredRoute = makeRoute config

        let configuredDeployment = makeDeployment config

        in  openshift.List::{
            , items =
                  [ openshift.Resource.Service configuredService
                  , openshift.Resource.Route configuredRoute
                  , openshift.Resource.Deployment configuredDeployment
                  ]
                # Prelude.map
                    openshift.PersistentVolumeClaim.Type
                    openshift.Resource
                    (   λ(volumeClaim : openshift.PersistentVolumeClaim.Type)
                      → openshift.Resource.PersistentVolumeClaim volumeClaim
                    )
                    config.volumeClaims
                # Prelude.map
                    openshift.ConfigMap.Type
                    openshift.Resource
                    (   λ(configMap : openshift.ConfigMap.Type)
                      → openshift.Resource.ConfigMap configMap
                    )
                    config.configMaps
                # Prelude.map
                    openshift.Secret.Type
                    openshift.Resource
                    (   λ(secret : openshift.Secret.Type)
                      → openshift.Resource.Secret secret
                    )
                    config.secrets
            }

in  makeApplication
