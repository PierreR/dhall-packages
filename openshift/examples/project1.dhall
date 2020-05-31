let oc =
      ../package.dhall sha256:6ef4eacc29986073de97ea4c9aee36240690b1d3684eb59bf112d204ddda682b

let project =
      oc.Project::{
      , name = "cicd-doc-dev"
      , displayName = "cicd doc for docs.cicd.cirb.lan"
      , requester = "cicd"
      }

in  project
