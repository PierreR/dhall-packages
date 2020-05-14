let ocp = ../package.dhall

let appShell =
      ocp.AppShell::{
      , namespace = "cicd-doc-dev"
      , displayName = "cicd doc for docs.cicd.cirb.lan"
      , quota = ocp.Quota::{
        , `limits.cpu` = "2"
        , `requests.cpu` = "1"
        , `limits.memory` = "2Gi"
        }
      }

in  ocp.makeAppShell appShell
