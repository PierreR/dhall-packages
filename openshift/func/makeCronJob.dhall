let Prelude = ../Prelude.dhall

let Container = ../schemas/Container.dhall

let Config = ../schemas/Cron.dhall

let openshift = ../packages/openshift.dhall

let makeContainer = ./makeContainer.dhall

let makeCronJob
    : Config.Type → openshift.CronJob.Type
    = λ(config : Config.Type) →
        openshift.CronJob::{
        , metadata = openshift.ObjectMeta::{
          , name = config.name
          , namespace = Some config.name
          }
        , spec = Some openshift.CronJobSpec::{
          , schedule = config.schedule
          , jobTemplate = openshift.JobTemplateSpec::{
            , metadata = openshift.ObjectMeta::{ name = config.name }
            , spec = Some openshift.JobSpec::{
              , template = openshift.PodTemplateSpec::{
                , metadata = openshift.ObjectMeta::{
                  , name = config.name
                  , labels = toMap { parent = config.name }
                  }
                , spec = Some openshift.PodSpec::{
                  , containers =
                      Prelude.map
                        Container.Type
                        openshift.Container.Type
                        makeContainer
                        config.containers
                  , initContainers =
                      Prelude.map
                        Container.Type
                        openshift.Container.Type
                        makeContainer
                        config.initContainers
                  }
                }
              }
            }
          }
        }

in  makeCronJob
