let argocd = ../packages/argocd.dhall

let App = ../schemas/App.dhall

let ObjectMeta =
      https://raw.githubusercontent.com/dhall-lang/dhall-kubernetes/master/1.17/schemas/io.k8s.apimachinery.pkg.apis.meta.v1.ObjectMeta.dhall

let makeArgo =
      λ(config : App.Type) →
        let targetRevision =
              merge
                { Some = λ(revision : Text) → revision, None = config.project }
                config.revision

        in  argocd.Application::{
            , metadata = ObjectMeta::{
              , name = Some config.name
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
                            , targetRevision = Some targetRevision
                            }
                    , None =
                        argocd.SourceSpec.TypesUnion.Directory
                          argocd.DirectorySourceSpec::{
                          , repoURL = config.repository
                          , path = config.path
                          , targetRevision = Some targetRevision
                          }
                    }
                    config.argoPlugin
              , destination = argocd.DestinationSpec::{
                , server = "https://kubernetes.default.svc"
                , namespace =
                    merge
                      { Some = λ(ns : Text) → ns, None = config.name }
                      config.namespace
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
