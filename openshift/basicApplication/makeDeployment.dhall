let Prelude = ../types/Prelude.dhall

let OpenShift = ../types/OpenShift.dhall

let Config = ./types/Config.dhall

let Container = ../types/Container.dhall

let makeContainer = ../makeContainer.dhall

let makeDeployment
    : Config.Type → OpenShift.Deployment.Type
    =   λ(config : Config.Type)
      → OpenShift.Deployment::{
        , metadata = OpenShift.ObjectMeta::{
          , name = config.name
          , namespace = Some config.name
          }
        , spec = Some OpenShift.DeploymentSpec::{
          , selector = OpenShift.LabelSelector::{
            , matchLabels = [ { mapKey = "app", mapValue = config.name } ]
            }
          , template = OpenShift.PodTemplateSpec::{
            , metadata = OpenShift.ObjectMeta::{
              , name = config.name
              , labels = [ { mapKey = "app", mapValue = config.name } ]
              }
            , spec = Some OpenShift.PodSpec::{
              , containers =
                  Prelude.map
                    Container.Type
                    OpenShift.Container.Type
                    makeContainer
                    config.containers
              , volumes = config.volumes
              }
            }
          , replicas = Some config.replicas
          }
        }

in  makeDeployment
