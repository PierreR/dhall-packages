let openshift = ../packages/openshift.dhall

let Config = ../schemas/Application.dhall

let makeRoute
    : Config.Type → openshift.Route.Type
    = λ(config : Config.Type) →
        openshift.Route::{
        , apiVersion = "route.openshift.io/v1"
        , metadata = openshift.ObjectMeta::{
          , name = config.name
          , namespace = Some config.name
          , annotations = toMap
              { `haproxy.router.openshift.io/timeout` = config.timeout }
          }
        , spec = openshift.RouteSpec::{
          , host = config.domain
          , path = Some "/"
          , to = openshift.RouteTargetReference::{
            , kind = "Service"
            , name = config.name
            , weight = 100
            }
          , tls =
              if    config.enableTLS
              then  Some openshift.TLSConfig::{ termination = "edge" }
              else  None openshift.TLSConfig.Type
          }
        }

in  makeRoute
