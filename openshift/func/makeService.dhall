let openshift = ../packages/openshift.dhall

let Service = ../schemas/Service.dhall

let makeService
    : Text → Service.Type → openshift.Service.Type
    = λ(namespace : Text) →
      λ(cfg : (../schemas/Service.dhall).Type) →
        let name =
              Some
                ( merge
                    { Some = λ(name : Text) → name, None = namespace ++ "-srv" }
                    cfg.name
                )

        in  openshift.Service::{
            , metadata = openshift.ObjectMeta::{
              , name
              , namespace = Some namespace
              }
            , spec = Some openshift.ServiceSpec::{
              , ports = Some
                [ openshift.ServicePort::{
                  , name = Some "http"
                  , protocol = Some cfg.protocol
                  , port = cfg.port
                  , targetPort = Some
                      (< Int : Natural | String : Text >.Int cfg.port)
                  }
                ]
              , selector = Some (toMap { app = namespace })
              , type = Some cfg.type
              }
            }

in  makeService
