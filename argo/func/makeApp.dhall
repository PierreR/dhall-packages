let argocd = ../packages/argocd.dhall

let packages = ../packages/dhall-packages.dhall

let App = ../schemas/App.dhall

let k8s = packages.kubernetes.k8s.`1-14`

let makeArgo =
      λ(config : App.Type) →
        argocd.Application::{
        , metadata = k8s.ObjectMeta::{
          , name = config.name
          , namespace = Some "argocd"
          }
        , spec = argocd.ApplicationSpec::{
          , project = config.project
          , source =
              merge
                { Some =
                    λ(plugin : Text) →
                      argocd.SourceSpec.TypesUnion.Plugin
                        argocd.PluginSourceSpec::{
                        , repoURL = config.repository
                        , path = config.path
                        , plugin = argocd.PluginSpec::{ name = plugin }
                        }
                , None =
                    argocd.SourceSpec.TypesUnion.Directory
                      argocd.DirectorySourceSpec::{
                      , repoURL = config.repository
                      , path = config.path
                      }
                }
                config.argoPlugin
          , destination = argocd.DestinationSpec::{
            , server = "https://kubernetes.default.svc"
            , namespace = config.name
            }
          , syncPolicy = Some argocd.SyncPolicy::{
            , automated = Some argocd.SyncPolicyAutomated::{
              , prune = Some True
              , selfHeal = Some True
              }
            }
          }
        }

in  makeArgo
