let OpenShift = ./types/OpenShift.dhall

let project
    : Text → Text → OpenShift.Project.Type
    =   λ(name : Text)
      → λ(displayName : Text)
      → OpenShift.Project::{
        , metadata = OpenShift.ObjectMeta::{
          , name = name
          , annotations =
            [ { mapKey = "openshift.io/display-name", mapValue = displayName }
            , { mapKey = "openshift.io/requester", mapValue = "cicd" }
            ]
          }
        }

in  project
