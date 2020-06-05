let openshift = ../packages/openshift.dhall

let Project = ../schemas/Project.dhall

let Quota = ../schemas/Quota.dhall

let makeQuota = ./makeQuota.dhall

let makeProject
    : Project.Type → openshift.List.Type
    = λ(proj : Project.Type) →
        let quota = makeQuota proj.name Quota::proj.quota

        let project =
              openshift.Namespace::{
              , metadata = openshift.ObjectMeta::{
                , name = Some proj.name
                , annotations = Some
                    ( toMap
                        { `openshift.io/display-name` = proj.displayName
                        , `openshift.io/requester` = proj.requester
                        }
                    )
                }
              }

        let items =
              [ openshift.Resource.Project project
              , openshift.Resource.ResourceQuota quota
              ]

        in  openshift.List::{ items }

in  makeProject
