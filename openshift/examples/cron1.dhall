let oc = ../package.dhall

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
