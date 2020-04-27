let BasicArgo = ../package.dhall

let configuration =
      BasicArgo.Config::{
      , name = "basic1-dev"
      , repository = "http://stash.cirb.lan/scm/oc/app1.git"
      }

in  BasicArgo.makeApplication configuration
