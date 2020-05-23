let openshift = ../packages/openshift.dhall

let Secret = ../schemas/Secret.dhall

let makeSecret
    : Secret.Type → openshift.Secret.Type
    = λ(cfg : Secret.Type) →
        openshift.Secret::(   cfg.{ type, data, stringData }
                            ⫽ { metadata = openshift.ObjectMeta::{
                                , name = Some cfg.name
                                }
                              }
                          )

in  makeSecret
