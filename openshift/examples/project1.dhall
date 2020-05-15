let ocp = ../package.dhall

let project =
      { name = "project1"
      , displayName = "display-project1"
      , requester = "cicd"
      }

in  ocp.makeProject project
