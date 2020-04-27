let BasicApplication = ../package.dhall

let configuration =
      BasicApplication.Config::{
      , name = "basic1"
      , domain = "basic1.cirb.lan"
      , port = 9999
      , containers =
        [ BasicApplication.Container::{
          , name = "basic1"
          , ports = [ 9999 ]
          , image = "cicd-docker.repository.irisnet.be/basic-app:0.2"
          }
        ]
      }

in  BasicApplication.makeApplication configuration
