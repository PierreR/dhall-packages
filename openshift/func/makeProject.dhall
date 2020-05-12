let openshift = ../packages/openshift.dhall

let project
    : Text → Text → openshift.Project.Type
    = λ(name : Text) →
      λ(displayName : Text) →
        openshift.Project::{
        , metadata = openshift.ObjectMeta::{
          , name
          , annotations = toMap
              { `openshift.io/display-name` = displayName
              , `openshift.io/requester` = "cicd"
              }
          }
        }

in  project
