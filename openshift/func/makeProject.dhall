let openshift = ../packages/openshift.dhall

let Project = ../schemas/Project.dhall

let Quota = ../schemas/Quota.dhall

let makeQuota = ./makeQuota.dhall

let makeRoleBinding = ./makeRoleBinding.dhall

let makeProject
    : Project.Type → openshift.List.Type
    = λ(proj : Project.Type) →
        let name =
              merge
                { Some =
                    λ(zone : Text) →
                      proj.stack ++ "-" ++ proj.projectName ++ "-" ++ zone
                , None = proj.stack ++ "-" ++ proj.projectName
                }
                proj.zone

        let quota = makeQuota name Quota::proj.quota

        let roleBinding = makeRoleBinding proj.stack name

        let project =
              openshift.Namespace::{
              , metadata = openshift.ObjectMeta::{
                , name = Some name
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
              , openshift.Resource.RoleBinding roleBinding
              ]

        in  openshift.List::{ items }

in  makeProject
