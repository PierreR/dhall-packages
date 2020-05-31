let oc =
      ../package.dhall sha256:6ef4eacc29986073de97ea4c9aee36240690b1d3684eb59bf112d204ddda682b

let configuration =
      oc.Cron::{
      , name = "cron1"
      , schedule = "*/1 * * * *"
      , containers =
        [ oc.Container::{
          , name = "basic1"
          , image = "cicd-docker.repository.irisnet.be/basic-task:0.2"
          }
        ]
      }

in  oc.makeCron configuration
