let ocp = ../package.dhall

let appShell =
      ocp.AppShell::{
      , namespace = "cicd-doc-dev"
      , displayName = "cicd doc for docs.cicd.cirb.lan"
      }

in  ocp.makeAppShell appShell
