let oc = ../package.dhall

let application =
      oc.Application::{
      , project =
        { name = "cicd-doc-dev"
        , displayName = "cicd doc for docs.cicd.cirb.lan"
        , requester = "cicd"
        }
      }

in  oc.makeApplication application
