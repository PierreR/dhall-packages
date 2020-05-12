let Prelude = ../Prelude.dhall

let openshift = ../packages/openshift.dhall

let Config = ../schemas/Application.dhall

let Container = ../schemas/Container.dhall

let makeContainer = ./makeContainer.dhall

let makeDeployment
    : Config.Type → openshift.Deployment.Type
    = λ(config : Config.Type) →
        openshift.Deployment::{
        , metadata = openshift.ObjectMeta::{
          , name = config.name
          , namespace = Some config.name
          }
        , spec = Some openshift.DeploymentSpec::{
          , selector = openshift.LabelSelector::{
            , matchLabels = toMap { app = config.name }
            }
          , template = openshift.PodTemplateSpec::{
            , metadata = openshift.ObjectMeta::{
              , name = config.name
              , labels = toMap { app = config.name }
              }
            , spec = Some openshift.PodSpec::{
              , containers =
                  Prelude.map
                    Container.Type
                    openshift.Container.Type
                    makeContainer
                    config.containers
              , volumes = config.volumes
              }
            }
          , replicas = Some config.replicas
          }
        }

in  makeDeployment
