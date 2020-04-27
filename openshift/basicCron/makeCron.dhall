let Config = ./types/Config.dhall

let OpenShift = ../types/OpenShift.dhall

let Prelude = ../types/Prelude.dhall

let makeCronJob = ./makeCronJob.dhall

let makeCron =
        λ(config : Config.Type)
      → let configuredCronJob = makeCronJob config

        in  OpenShift.List::{
            , items =
                  [ OpenShift.Resource.CronJob configuredCronJob ]
                # Prelude.map
                    OpenShift.ConfigMap.Type
                    OpenShift.Resource
                    (   λ(configMap : OpenShift.ConfigMap.Type)
                      → OpenShift.Resource.ConfigMap configMap
                    )
                    config.configMaps
                # Prelude.map
                    OpenShift.Secret.Type
                    OpenShift.Resource
                    (   λ(secret : OpenShift.Secret.Type)
                      → OpenShift.Resource.Secret secret
                    )
                    config.secrets
            }

in  makeCron
