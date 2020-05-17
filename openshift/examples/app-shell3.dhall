let ocp = ../package.dhall

let appShell =
      ocp.AppShell::{
      , project =
        { name = "cicd-doc-dev"
        , displayName = "cicd doc for docs.cicd.cirb.lan"
        , requester = "cicd"
        }
      , deployment = Some ocp.Deployment::{
        , replicas = 2
        , containers =
          [ ocp.Container::{
            , name = "cicd-docs"
            , ports = Some [ 8080 ]
            , image = "cicd-docker.repository.irisnet.be/cicd-docs"
            }
          ]
        }
      , service = Some ocp.Service::{ targetPort = 8080 }
      , route = Some ocp.Route::{ domain = "docs.cicd.cirb.lan" }
      }

in  ocp.makeAppShell appShell
