let Cron = ../schemas/Cron.dhall

let openshift = ../packages/openshift.dhall

let Prelude = ../Prelude.dhall

let makeCronJob = ./makeCronJob.dhall

let makeCron =
      λ(config : Cron.Type) →
        let configuredCronJob = makeCronJob config

        in  openshift.List::{
            , items =
                  [ openshift.Resource.CronJob configuredCronJob ]
                # Prelude.map
                    openshift.ConfigMap.Type
                    openshift.Resource
                    ( λ(configMap : openshift.ConfigMap.Type) →
                        openshift.Resource.ConfigMap configMap
                    )
                    config.configMaps
                # Prelude.map
                    openshift.Secret.Type
                    openshift.Resource
                    ( λ(secret : openshift.Secret.Type) →
                        openshift.Resource.Secret secret
                    )
                    config.secrets
            }

in  makeCron
