let ocp = ../package.dhall

let appShell =
      ocp.AppShell::{
      , project =
        { name = "cicd-doc-dev"
        , displayName = "cicd doc for docs.cicd.cirb.lan"
        , requester = "cicd"
        }
      , quota = ocp.Quota::{
        , `limits.cpu` = "2"
        , `requests.cpu` = "1"
        , `limits.memory` = "2Gi"
        }
      }

in  ocp.makeAppShell appShell
