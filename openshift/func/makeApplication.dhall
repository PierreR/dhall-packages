let List/map = (../../Prelude.dhall).List.map

let openshift = ../packages/openshift.dhall

let makeProject = ./makeProject.dhall

let makeQuota = ./makeQuota.dhall

let makeDeployment = ./makeDeployment.dhall

let makeService = ./makeService.dhall

let makeRoute = ./makeRoute.dhall

let Application = ../schemas/Application.dhall

let Quota = ../schemas/Quota.dhall

let Deployment = ../schemas/Deployment.dhall

let Secret = ../schemas/Secret.dhall

let Service = ../schemas/Service.dhall

let Route = ../schemas/Route.dhall

let makeApplication =
      λ(app : Application.Type) →
        let project = makeProject app.project

        let quota = makeQuota app.project.name Quota::app.quota

        let deploymentResource =
              merge
                { None = [] : List openshift.Resource
                , Some =
                    λ(d : Deployment.Type) →
                      [ openshift.Resource.Deployment
                          (makeDeployment app.project.name Deployment::d)
                      ]
                }
                app.deployment

        let serviceResource =
              merge
                { None = [] : List openshift.Resource
                , Some =
                    λ(srv : Service.Type) →
                      [ openshift.Resource.Service
                          ( makeService
                              app.project.name
                              app.enableTLS
                              Service::srv
                          )
                      ]
                }
                app.service

        let routeResource =
              merge
                { None = [] : List openshift.Resource
                , Some =
                    λ(route : Route.Type) →
                      [ openshift.Resource.Route
                          ( makeRoute
                              app.project.name
                              app.enableTLS
                              Route::route
                          )
                      ]
                }
                app.route

        let volumeClaimResource =
              merge
                { None = [] : List openshift.Resource
                , Some =
                    λ(pvcs : List openshift.PersistentVolumeClaim.Type) →
                      List/map
                        openshift.PersistentVolumeClaim.Type
                        openshift.Resource
                        ( λ(pvc : openshift.PersistentVolumeClaim.Type) →
                            openshift.Resource.PersistentVolumeClaim pvc
                        )
                        pvcs
                }
                app.volumeClaims

        let secretResource =
              merge
                { None = [] : List openshift.Resource
                , Some =
                    λ(secrets : List Secret.Type) →
                      List/map
                        Secret.Type
                        openshift.Resource
                        ( λ(secret : Secret.Type) →
                            openshift.Resource.Secret secret
                        )
                        secrets
                }
                app.secrets

        let configMapResource =
              merge
                { None = [] : List openshift.Resource
                , Some =
                    λ(cms : List openshift.ConfigMap.Type) →
                      List/map
                        openshift.ConfigMap.Type
                        openshift.Resource
                        ( λ(cm : openshift.ConfigMap.Type) →
                            openshift.Resource.ConfigMap cm
                        )
                        cms
                }
                app.configMaps

        let items =
                [ openshift.Resource.Project project
                , openshift.Resource.ResourceQuota quota
                ]
              # deploymentResource
              # volumeClaimResource
              # configMapResource
              # secretResource
              # serviceResource
              # routeResource

        in  openshift.List::{ items }

in  makeApplication
