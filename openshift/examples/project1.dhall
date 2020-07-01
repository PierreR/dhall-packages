let oc =
      ../package.dhall sha256:5c0bd30ac3c1d0914770754fe82256720a04471f38a26bbc6b63bd7ebd9eea94

let project =
      oc.Project::{
      , stack = "cicd"
      , projectName = "doc"
      , zone = Some "dev"
      , displayName = "cicd doc for docs.cicd.cirb.lan"
      , requester = "cicd"
      }

in  oc.makeProject project
