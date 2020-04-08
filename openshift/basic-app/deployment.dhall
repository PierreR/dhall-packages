let OpenShift =
      ./openshift.dhall sha256:422477ee4999e20e3aa0486f9b25c5728e7e266d42b143b53578eff44e92f009

let Config = ./config.dhall

let deployment
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
                [ OpenShift.Container::{
                  , name = config.name
                  , image = Some config.image
                  , env = config.envVars
                  , ports =
                    [ OpenShift.ContainerPort::{
                      , containerPort = config.appPort
                      }
                    ]
                  }
                ]
              }
            }
          , replicas = Some config.replicas
          }
        }

in  deployment
