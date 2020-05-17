let openshift = ../packages/openshift.dhall

in  { Type = openshift.Secret.Type
    , default = openshift.Secret.default ⫽ { type = Some "Opaque" }
    }
