let oc = ../package.dhall

let appShell =
      oc.AppShell::{
      , project =
        { name = "cicd-doc-dev"
        , displayName = "cicd doc for docs.cicd.cirb.lan"
        , requester = "cicd"
        }
      }

in  oc.makeAppShell appShell
