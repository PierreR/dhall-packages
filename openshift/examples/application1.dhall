let oc = ../package.dhall

let configuration =
      oc.Application::{
      , name = "basic1"
      , route = oc.Route::{ domain = "basic1.cirb.lan", path = Some "/" }
      , service = oc.Service::{ targetPort = 9999 }
      , deployment = oc.Deployment::{
        , replicas = 2
        , containers =
          [ oc.Container::{
            , name = "basic1"
            , ports = Some [ 9999 ]
            , image = "cicd-docker.repository.irisnet.be/basic-app:0.2"
            }
          ]
        }
      }

in  oc.makeApplication configuration
