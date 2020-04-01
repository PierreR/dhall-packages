let OpenShift =
      ./openshift.dhall sha256:422477ee4999e20e3aa0486f9b25c5728e7e266d42b143b53578eff44e92f009

let Config =
      ./config.dhall sha256:4874db1ff90d389cb1616a1fb869d0ec6b83182b994e8118ebcb6cb7e6089e93

let route
    : Config.Type → OpenShift.Route.Type
    =   λ(config : Config.Type)
      → OpenShift.Route::{
        , metadata = OpenShift.ObjectMeta::{ name = config.name }
        , spec = OpenShift.RouteSpec::{
          , host = "nixery.apps.its.paas.cirb.lan"
          , path = Some "/"
          , to = OpenShift.RouteTargetReference::{
            , kind = "Service"
            , name = "nixery"
            , weight = 0
            }
          }
        }

in  route
