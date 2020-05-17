let openshift = ../packages/openshift.dhall

let Route = ../schemas/Route.dhall

let makeRoute
    : Text → Bool → Route.Type → openshift.Route.Type
    = λ(namespace : Text) →
      λ(enableTLS : Bool) →
      λ(cfg : Route.Type) →
        let name = namespace ++ "-route"

        in  openshift.Route::{
            , apiVersion = cfg.apiVersion
            , metadata = openshift.ObjectMeta::{
              , name = Some name
              , namespace = Some namespace
              , annotations = Some
                  ( toMap
                      { `haproxy.router.openshift.io/timeout` = cfg.timeout }
                  )
              }
            , spec = openshift.RouteSpec::{
              , host = cfg.domain
              , path = cfg.path
              , to = openshift.RouteTargetReference::{
                , kind = "Service"
                , name = namespace ++ "-srv"
                , weight = 100
                }
              , tls =
                  if    enableTLS
                  then  Some openshift.TLSConfig::{ termination = "edge" }
                  else  None openshift.TLSConfig.Type
              }
            }

in  makeRoute
