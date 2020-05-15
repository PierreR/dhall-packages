let openshift = ../packages/openshift.dhall

let quota =
      λ(namespace : Text) →
      λ(config : (../schemas/Quota.dhall).Type) →
        let name = namespace ++ "-quota"

        in  openshift.ResourceQuota::{
            , metadata = openshift.ObjectMeta::{
              , name
              , namespace = Some namespace
              }
            , spec = Some openshift.ResourceQuotaSpec::{ hard = toMap config }
            }

in  quota
