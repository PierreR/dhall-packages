let OpenShift =
      ./openshift.dhall sha256:422477ee4999e20e3aa0486f9b25c5728e7e266d42b143b53578eff44e92f009

let Config = ./config.dhall

let route
    : Config.Type → OpenShift.Route.Type
    =   λ(config : Config.Type)
      → OpenShift.Route::{
        , metadata = OpenShift.ObjectMeta::{ name = config.name }
        , spec = OpenShift.RouteSpec::{
          , host = config.domain
          , path = Some "/"
          , to = OpenShift.RouteTargetReference::{
            , kind = "Service"
            , name = config.name
            , weight = 100
            }
          }
        }

in  route
