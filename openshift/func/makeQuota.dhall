let openshift = ../packages/openshift.dhall

let quota =
      λ(name : Text) →
      λ(config : (../schemas/Quota.dhall).Type) →
        let name = name ++ "-quota"

        in  openshift.ResourceQuota::{
            , metadata = openshift.ObjectMeta::{ name }
            , spec = Some openshift.ResourceQuotaSpec::{ hard = toMap config }
            }

in  quota
