let ocp =
      ../package.dhall sha256:ab5abf098ad2136c82d7157f8aa1b63f562275e8a8350375753ab579bf6b6b69

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
