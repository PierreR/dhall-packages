let openshift = ../packages/openshift.dhall

let quota =
      λ(namespace : Text) →
      λ(config : (../schemas/Quota.dhall).Type) →
        let name = namespace ++ "-quota"

        in  openshift.ResourceQuota::{
            , metadata = openshift.ObjectMeta::{
              , name = Some name
              , namespace = Some namespace
              }
            , spec = Some openshift.ResourceQuotaSpec::{
              , hard = Some (toMap config)
              }
            }

in  quota
