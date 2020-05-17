let openshift = ../packages/openshift.dhall

let Service = ../schemas/Service.dhall

let makeService
    : Text → Bool → Service.Type → openshift.Service.Type
    = λ(namespace : Text) →
      λ(enableTLS : Bool) →
      λ(srv : (../schemas/Service.dhall).Type) →
        let name = namespace ++ "-srv"

        in  openshift.Service::{
            , metadata = openshift.ObjectMeta::{
              , name = Some name
              , namespace = Some namespace
              }
            , spec = Some openshift.ServiceSpec::{
              , ports = Some
                [ openshift.ServicePort::{
                  , name = Some "http"
                  , protocol = Some srv.protocol
                  , port = if enableTLS then 443 else 80
                  , targetPort = Some
                      (< Int : Natural | String : Text >.Int srv.targetPort)
                  }
                ]
              , selector = Some (toMap { app = namespace })
              , type = Some srv.type
              }
            }

in  makeService
