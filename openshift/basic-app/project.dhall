let OpenShift = ./openshift.dhall

let Config = ./config.dhall

let project
    : Config.Type → OpenShift.Project.Type
    =   λ(config : Config.Type)
      → OpenShift.Project::{
        , metadata = OpenShift.ObjectMeta::{
          , name = "nixery"
          , annotations =
            [ { mapKey = "openshift.io/display-name"
              , mapValue = config.displayName
              }
            , { mapKey = "openshift.io/requester", mapValue = "cicd" }
            ]
          }
        }

in  project
