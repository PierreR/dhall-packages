let openshift = ../packages/openshift.dhall

let makeProject = ./makeProject.dhall

let makeQuota = ./makeQuota.dhall

let makeDeployment = ./makeDeployment.dhall

let makeService = ./makeService.dhall

let makeRoute = ./makeRoute.dhall

let Quota = ../schemas/Quota.dhall

let Deployment = ../schemas/Deployment.dhall

let Service = ../schemas/Service.dhall

let Route = ../schemas/Route.dhall

let AppShell = ../schemas/AppShell.dhall

let makeAppShell =
      λ(app : AppShell.Type) →
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

        let items =
                [ openshift.Resource.Project project
                , openshift.Resource.ResourceQuota quota
                ]
              # deploymentResource
              # serviceResource
              # routeResource

        in  openshift.List::{ items }

in  makeAppShell
