let openshift = ../packages/openshift.dhall

let Project = ../schemas/Project.dhall

let project
    : Project → openshift.Project.Type
    = λ(project : Project) →
        openshift.Project::{
        , metadata = openshift.ObjectMeta::{
          , name = project.name
          , annotations = toMap
              { `openshift.io/display-name` = project.displayName
              , `openshift.io/requester` = project.requester
              }
          }
        }

in  project
