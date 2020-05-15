let ocp = ../package.dhall

let appShell =
      ocp.AppShell::{
      , project =
        { name = "cicd-doc-dev"
        , displayName = "cicd doc for docs.cicd.cirb.lan"
        , requester = "cicd"
        }
      }

in  ocp.makeAppShell appShell
