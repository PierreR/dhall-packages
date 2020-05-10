let openshift = ../packages/openshift.dhall

let Config = ../schemas/Application.dhall

let makeService
    : Config.Type → openshift.Service.Type
    = λ(config : Config.Type) →
        openshift.Service::{
        , metadata = openshift.ObjectMeta::{
          , name = config.name
          , namespace = Some config.name
          }
        , spec = Some openshift.ServiceSpec::{
          , ports =
            [ openshift.ServicePort::{
              , name = Some "http"
              , protocol = Some "TCP"
              , port = if config.enableTLS then 443 else 80
              , targetPort = Some
                  (< Int : Natural | String : Text >.Int config.port)
              }
            ]
          , selector = [ { mapKey = "app", mapValue = config.name } ]
          }
        }

in  makeService
