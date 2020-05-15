let makeProject = ./makeProject.dhall

let makeQuota = ./makeQuota.dhall

let Quota = ../schemas/Quota.dhall

let AppShell = ../schemas/AppShell.dhall

let openshift = ../packages/openshift.dhall

let makeAppShell =
      λ(appShell : AppShell.Type) →
        let project = makeProject appShell.project

        let quota = makeQuota appShell.project.name Quota::appShell.quota

        in  openshift.List::{
            , items =
              [ openshift.Resource.Project project
              , openshift.Resource.ResourceQuota quota
              ]
            }

in  makeAppShell
