let BasicCron = ../package.dhall

let configuration =
      BasicCron.Config::{
      , name = "cron1"
      , schedule = "*/1 * * * *"
      , containers =
        [ BasicCron.Container::{
          , name = "basic1"
          , image = "cicd-docker.repository.irisnet.be/basic-task:0.2"
          }
        ]
      }

in  BasicCron.makeCron configuration
