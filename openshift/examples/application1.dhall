let ocp = ../package.dhall

let configuration =
      ocp.Application::{
      , name = "basic1"
      , domain = "basic1.cirb.lan"
      , port = 9999
      , containers =
        [ ocp.Container::{
          , name = "basic1"
          , ports = [ 9999 ]
          , image = "cicd-docker.repository.irisnet.be/basic-app:0.2"
          }
        ]
      }

in  ocp.makeApplication configuration
