let List/map = (../../Prelude.dhall).List.map

let openshift = ../packages/openshift.dhall

let makeDeployment = ./makeDeployment.dhall

let makeService = ./makeService.dhall

let makeSecret = ./makeSecret.dhall

let makeRoute = ./makeRoute.dhall

let Application = ../schemas/Application.dhall

let Deployment = ../schemas/Deployment.dhall

let Secret = ../schemas/Secret.dhall

let Service = ../schemas/Service.dhall

let Route = ../schemas/Route.dhall

let makeApplication =
      λ(app : Application.Type) →
        let deploymentResource =
              merge
                { None = [] : List openshift.Resource
                , Some =
                    λ(d : Deployment.Type) →
                      [ openshift.Resource.Deployment
                          (makeDeployment app.namespace Deployment::d)
                      ]
                }
                app.deployment

        let serviceResource =
              merge
                { None = [] : List openshift.Resource
                , Some =
                    λ(srv : Service.Type) →
                      [ openshift.Resource.Service
                          (makeService app.namespace Service::srv)
                      ]
                }
                app.service

        let routeResource =
              merge
                { None = [] : List openshift.Resource
                , Some =
                    λ(route : Route.Type) →
                      [ openshift.Resource.Route
                          (makeRoute app.namespace Route::route)
                      ]
                }
                app.route

        let volumeResource =
              merge
                { None = [] : List openshift.Resource
                , Some =
                    λ(vols : List openshift.Volume.Type) →
                      List/map
                        openshift.Volume.Type
                        openshift.Resource
                        ( λ(vol : openshift.Volume.Type) →
                            openshift.Resource.Volume vol
                        )
                        vols
                }
                app.volumes

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
                            openshift.Resource.Secret
                              (makeSecret Secret::secret)
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
                deploymentResource
              # volumeResource
              # volumeClaimResource
              # configMapResource
              # secretResource
              # serviceResource
              # routeResource

        in  openshift.List::{ items }

in  makeApplication
