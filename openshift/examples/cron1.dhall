let ocp = ../package.dhall

let configuration =
      ocp.Cron::{
      , name = "cron1"
      , schedule = "*/1 * * * *"
      , containers =
        [ ocp.Container::{
          , name = "basic1"
          , image = "cicd-docker.repository.irisnet.be/basic-task:0.2"
          }
        ]
      }

in  ocp.makeCron configuration
