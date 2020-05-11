let ocp =
      ../package.dhall sha256:ab5abf098ad2136c82d7157f8aa1b63f562275e8a8350375753ab579bf6b6b69

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
