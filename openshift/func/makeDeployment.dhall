-- The name of the deployment is the namespace of the application
let List/map = (../../Prelude.dhall).List.map

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
          , name = Some namespace
          , namespace = Some namespace
          }
        , spec = Some openshift.DeploymentSpec::{
          , selector = openshift.LabelSelector::{
            , matchLabels = Some (toMap { app = namespace })
            }
          , template = openshift.PodTemplateSpec::{
            , metadata = openshift.ObjectMeta::{
              , name = Some namespace
              , labels = Some (toMap { app = namespace })
              }
            , spec = Some openshift.PodSpec::{
              , containers =
                  List/map
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
