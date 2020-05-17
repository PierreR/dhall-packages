let List/map = (../../Prelude.dhall).List.map

let makeRoute = ./makeRoute.dhall

let makeService = ./makeService.dhall

let makeDeployment = ./makeDeployment.dhall

let Application = ../schemas/Application.dhall

let openshift = ../packages/openshift.dhall

let makeApplication =
      λ(cfg : Application.Type) →
        let service = makeService cfg.name cfg.enableTLS cfg.service

        let route = makeRoute cfg.name cfg.enableTLS cfg.route

        let deployment = makeDeployment cfg.name cfg.deployment

        in  openshift.List::{
            , items =
                  [ openshift.Resource.Service service
                  , openshift.Resource.Route route
                  , openshift.Resource.Deployment deployment
                  ]
                # List/map
                    openshift.PersistentVolumeClaim.Type
                    openshift.Resource
                    ( λ(volumeClaim : openshift.PersistentVolumeClaim.Type) →
                        openshift.Resource.PersistentVolumeClaim volumeClaim
                    )
                    cfg.volumeClaims
                # List/map
                    openshift.ConfigMap.Type
                    openshift.Resource
                    ( λ(configMap : openshift.ConfigMap.Type) →
                        openshift.Resource.ConfigMap configMap
                    )
                    cfg.configMaps
                # List/map
                    openshift.Secret.Type
                    openshift.Resource
                    ( λ(secret : openshift.Secret.Type) →
                        openshift.Resource.Secret secret
                    )
                    cfg.secrets
            }

in  makeApplication
