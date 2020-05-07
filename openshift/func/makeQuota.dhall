let openshift = ../packages/openshift.dhall

let quota =
        λ(name : Text)
      → λ(config : (../schemas/Quota.dhall).Type)
      → openshift.ResourceQuota::{
        , metadata = openshift.ObjectMeta::{ name = name }
        , spec = Some openshift.ResourceQuotaSpec::{ hard = toMap config }
        }

in  quota
