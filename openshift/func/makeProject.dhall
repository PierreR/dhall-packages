let openshift = ../packages/openshift.dhall

let project
    : Text → Text → openshift.Project.Type
    =   λ(name : Text)
      → λ(displayName : Text)
      → openshift.Project::{
        , metadata = openshift.ObjectMeta::{
          , name = name
          , annotations =
            [ { mapKey = "openshift.io/display-name", mapValue = displayName }
            , { mapKey = "openshift.io/requester", mapValue = "cicd" }
            ]
          }
        }

in  project
