let argo = ../package.dhall

let configuration =
      argo.App::{
      , name = "basic1-dev"
      , repository = "http://stash.cirb.lan/scm/oc/app1.git"
      }

in  argo.makeApp configuration
