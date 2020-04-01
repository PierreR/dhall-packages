let OpenShift = ./openshift.dhall

let Config = ./config.dhall

let service
    : Config.Type → OpenShift.Service.Type
    =   λ(config : Config.Type)
      → OpenShift.Service::{
        , metadata = OpenShift.ObjectMeta::{ name = "nixery" }
        , spec = Some OpenShift.ServiceSpec::{
          , ports =
            [ OpenShift.ServicePort::{
              , name = Some "http"
              , protocol = Some "TCP"
              , port = 80
              , nodePort = Some 9999
              }
            ]
          }
        }

in  service
