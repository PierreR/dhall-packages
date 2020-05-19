let oc = ../package.dhall

let project =
      oc.Project::{
      , name = "cicd-doc-dev"
      , displayName = "cicd doc for docs.cicd.cirb.lan"
      , requester = "cicd"
      }

in  project
