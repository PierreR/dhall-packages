let List/map = (../../Prelude.dhall).List.map

let Optional/map = (../../Prelude.dhall).Optional.map

let Container = ../schemas/Container.dhall

let Config = ../schemas/Cron.dhall

let openshift = ../packages/openshift.dhall

let makeContainer = ./makeContainer.dhall

let makeCronJob
    : Config.Type → openshift.CronJob.Type
    = λ(config : Config.Type) →
        openshift.CronJob::{
        , metadata = openshift.ObjectMeta::{
          , name = Some config.name
          , namespace = Some config.name
          }
        , spec = Some openshift.CronJobSpec::{
          , schedule = config.schedule
          , jobTemplate = openshift.JobTemplateSpec::{
            , metadata = openshift.ObjectMeta::{ name = Some config.name }
            , spec = Some openshift.JobSpec::{
              , template = openshift.PodTemplateSpec::{
                , metadata = openshift.ObjectMeta::{
                  , name = Some config.name
                  , labels = Some (toMap { parent = config.name })
                  }
                , spec = Some openshift.PodSpec::{
                  , containers =
                      List/map
                        Container.Type
                        openshift.Container.Type
                        makeContainer
                        config.containers
                  , initContainers =
                      Optional/map
                        (List Container.Type)
                        (List openshift.Container.Type)
                        ( List/map
                            Container.Type
                            openshift.Container.Type
                            makeContainer
                        )
                        config.initContainers
                  }
                }
              }
            }
          }
        }

in  makeCronJob
