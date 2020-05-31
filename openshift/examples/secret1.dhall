let oc =
      ../package.dhall sha256:6ef4eacc29986073de97ea4c9aee36240690b1d3684eb59bf112d204ddda682b

let secret =
      oc.Secret::{
      , name = "secret1"
      , type = Some "coco"
      , data = Some
          ( toMap
              { `test.crt` =
                  ./test.pem sha256:ed987949764004d6b39c6f8462e072a585f9c589c31544f95392589780254384 as Text
              }
          )
      }

in  secret
