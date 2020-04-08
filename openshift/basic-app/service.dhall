let OpenShift = ./openshift.dhall

let Config = ./config.dhall

let service
    : Config.Type → OpenShift.Service.Type
    =   λ(config : Config.Type)
      → OpenShift.Service::{
        , metadata = OpenShift.ObjectMeta::{
          , name = config.name
          , namespace = Some config.name
          }
        , spec = Some OpenShift.ServiceSpec::{
          , ports =
            [ OpenShift.ServicePort::{
              , name = Some "http"
              , protocol = Some "TCP"
              , port = if config.enableTLS then 443 else 80
              , targetPort = Some
                  (< Int : Natural | String : Text >.Int config.appPort)
              }
            ]
          , selector = [ { mapKey = "app", mapValue = config.name } ]
          }
        }

in  service
