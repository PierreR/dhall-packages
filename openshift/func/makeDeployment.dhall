-- The name of the deployment is the namespace of the application
let map = (../../Prelude.dhall).List.map

let openshift = ../packages/openshift.dhall

let Deployment = ../schemas/Deployment.dhall

let Container = ../schemas/Container.dhall

let makeContainer = ./makeContainer.dhall

let makeDeployment
    : Text → Deployment.Type → openshift.Deployment.Type
    = λ(namespace : Text) →
      λ(cfg : Deployment.Type) →
        openshift.Deployment::{
        , metadata = openshift.ObjectMeta::{
          , name = namespace
          , namespace = Some namespace
          }
        , spec = Some openshift.DeploymentSpec::{
          , selector = openshift.LabelSelector::{
            , matchLabels = toMap { app = namespace }
            }
          , template = openshift.PodTemplateSpec::{
            , metadata = openshift.ObjectMeta::{
              , name = namespace
              , labels = toMap { app = namespace }
              }
            , spec = Some openshift.PodSpec::{
              , containers =
                  map
                    Container.Type
                    openshift.Container.Type
                    makeContainer
                    cfg.containers
              , volumes = cfg.volumes
              }
            }
          , replicas = Some cfg.replicas
          }
        }

in  makeDeployment
