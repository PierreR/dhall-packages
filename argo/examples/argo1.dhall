let argo = ../package.dhall sha256:39af80b2f2c967cd71e8168df7d1d853f49103002ff6c67d710a0fcdc0421cd5

let configuration =
      argo.App::{
      , project = "cicd"
      , name = "app1-dev"
      , path = "sbx/application/app1/dev"
      }

in  argo.makeApp configuration
