let openshift = ../packages/openshift.dhall

in  { Type =
        { name : Optional Text
        , type : Text
        , ports : List openshift.ServicePort.Type
        }
    , default =
      { name = None Text
      , type = "ClusterIP"
      , ports =
        [ openshift.ServicePort::{
          , name = Some "http"
          , protocol = Some "TCP"
          , port = 80
          , targetPort = Some (< Int : Natural | String : Text >.Int 80)
          }
        ]
      }
    }
