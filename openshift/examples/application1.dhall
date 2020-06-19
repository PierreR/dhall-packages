let oc = env:OC

let application =
      oc.Application::{
      , namespace = "application1-dev"
      , deployment = Some oc.Deployment::{
        , replicas = 2
        , containers =
          [ oc.Container::{
            , name = "cicd-docs"
            , ports = Some [ 8080 ]
            , image = "app1-docker.repository.irisnet.be/cicd-docs"
            , volumeMounts = Some
              [ oc.core.VolumeMount::{
                , name = "test-data"
                , mountPath = "/etc/data"
                }
              ]
            , envVars = Some
              [ oc.core.EnvVar::{
                , name = "NIX_PATH"
                , value = Some
                    "nixpkgs-overlays=http://stash.cirb.lan/CICD/nixpkgs-overlays/archive/master.tar.gz"
                }
              ]
            }
          ]
        }
      , volumes = Some
        [ oc.core.Volume::{
          , name = "nix-config"
          , configMap = Some oc.core.ConfigMapVolumeSource::{
            , name = Some "test-data"
            , items = Some
              [ oc.core.KeyToPath::{ key = "test.conf", path = "test.conf" } ]
            }
          }
        , oc.core.Volume::{
          , name = "test-crt"
          , secret = Some oc.core.SecretVolumeSource::{
            , secretName = Some "test-crt"
            , items = Some
              [ oc.core.KeyToPath::{ key = "ca.pem", path = "ca.pem" } ]
            }
          }
        ]
      , volumeClaims = Some
        [ oc.core.PersistentVolumeClaim::{
          , metadata = oc.core.ObjectMeta::{ name = Some "nixery-storage" }
          , kind = "PersistentVolumeClaim"
          , spec = Some oc.core.PersistentVolumeClaimSpec::{
            , accessModes = Some [ "ReadWriteOnce" ]
            , resources = Some oc.core.ResourceRequirements::{
              , requests = Some (toMap { storage = "10Gi" })
              }
            , volumeName = Some "pv-nfs-sbx-vol04"
            , storageClassName = Some "slow"
            }
          }
        ]
      , configMaps = Some
        [ oc.core.ConfigMap::{
          , metadata = oc.core.ObjectMeta::{ name = Some "test-data" }
          , data = Some
              ( toMap
                  { `test.conf` =
                      ./test.conf sha256:05d38a27ab242684458aa288386f311214dfe423fbeccda74f66b63aa2ebb9f8 as Text
                  }
              )
          }
        ]
      , secrets = Some
        [ oc.Secret::{
          , name = "test.crt"
          , data = Some
              ( toMap
                  { `test.crt` =
                      ./test.pem sha256:ed987949764004d6b39c6f8462e072a585f9c589c31544f95392589780254384 as Text
                  }
              )
          }
        ]
      , service = Some oc.Service::{ ports = [ 8080 ] }
      , route = Some oc.Route::{ domain = "app1.cicd.cirb.lan" }
      }

in  oc.makeApplication application
