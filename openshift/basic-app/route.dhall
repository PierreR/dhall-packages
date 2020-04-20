let OpenShift =
      ./openshift.dhall sha256:422477ee4999e20e3aa0486f9b25c5728e7e266d42b143b53578eff44e92f009

let Config = ./config.dhall

let route
    : Config.Type → OpenShift.Route.Type
    =   λ(config : Config.Type)
      → OpenShift.Route::{
        , apiVersion = "route.openshift.io/v1"
        , metadata = OpenShift.ObjectMeta::{
          , name = config.name
          , namespace = Some config.name
          , annotations =
            [ { mapKey = "haproxy.router.openshift.io/timeout"
              , mapValue = config.timeout
              }
            ]
          }
        , spec = OpenShift.RouteSpec::{
          , host = config.domain
          , path = Some "/"
          , to = OpenShift.RouteTargetReference::{
            , kind = "Service"
            , name = config.name
            , weight = 100
            }
          , tls =
                    if config.enableTLS

              then  Some OpenShift.TLSConfig::{ termination = "edge" }

              else  None OpenShift.TLSConfig.Type
          }
        }

in  route
