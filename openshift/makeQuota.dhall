let OpenShift = ./types/OpenShift.dhall

let quota
    : Text → Text → OpenShift.ResourceQuota.Type
    =   λ(name : Text)
      → λ(cpuRequests : Text)
      → λ(cpuLimits : Text)
      → λ(memoryRequests : Text)
      → λ(memoryLimits : Text)
      → OpenShift.ResourceQuota::{
        , metadata = OpenShift.ObjectMeta::{ name = name }
        , spec = OpenShift.ResourceQuotaSpec::{
          , scopes = namespace
          , hard =
            [ { mapKey = "requests.cpu", mapValue = cpuRequests }
            , { mapKey = "requests.memory", mapValue = memoryRequests }
            , { mapKey = "limits.cpu", mapValue = cpuLimits }
            , { mapKey = "limits.memory", mapValue = memoryLimits }
            ]
          }
        }

in  quota
