let ocp = ../package.dhall

let configuration =
      ocp.Application::{
      , name = "basic1"
      , route = ocp.Route::{ domain = "basic1.cirb.lan", path = Some "/" }
      , service = ocp.Service::{ targetPort = 9999 }
      , deployment = ocp.Deployment::{
        , replicas = 2
        , containers =
          [ ocp.Container::{
            , name = "basic1"
            , ports = Some [ 9999 ]
            , image = "cicd-docker.repository.irisnet.be/basic-app:0.2"
            }
          ]
        }
      }

in  ocp.makeApplication configuration
