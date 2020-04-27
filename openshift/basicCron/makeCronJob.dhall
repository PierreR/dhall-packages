let Prelude = ../types/Prelude.dhall

let Container = ../types/Container.dhall

let Config = ./types/Config.dhall

let OpenShift = ../types/OpenShift.dhall

let makeContainer = ../makeContainer.dhall

let makeCronJob
    : Config.Type → OpenShift.CronJob.Type
    =   λ(config : Config.Type)
      → OpenShift.CronJob::{
        , metadata = OpenShift.ObjectMeta::{
          , name = config.name
          , namespace = Some config.name
          }
        , spec = Some OpenShift.CronJobSpec::{
          , schedule = config.schedule
          , jobTemplate = OpenShift.JobTemplateSpec::{
            , metadata = OpenShift.ObjectMeta::{ name = config.name }
            , spec = Some OpenShift.JobSpec::{
              , template = OpenShift.PodTemplateSpec::{
                , metadata = OpenShift.ObjectMeta::{
                  , name = config.name
                  , labels = [ { mapKey = "parent", mapValue = config.name } ]
                  }
                , spec = Some OpenShift.PodSpec::{
                  , containers =
                      Prelude.map
                        Container.Type
                        OpenShift.Container.Type
                        makeContainer
                        config.containers
                  , initContainers =
                      Prelude.map
                        Container.Type
                        OpenShift.Container.Type
                        makeContainer
                        config.initContainers
                  }
                }
              }
            }
          }
        }

in  makeCronJob
