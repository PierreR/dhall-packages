let argo =
      ../package.dhall sha256:52ac9005b563dc0882df4667c9bd330580abf482fc1a33899ac860527cda65d7

let configuration =
      argo.App::{
      , project = "cicd"
      , name = "app1-dev"
      , path = "sbx/application/app1/dev"
      }

in  argo.makeApp configuration
