-- Minimal resources built from an 'application-form'
let Quota = ../schemas/Quota.dhall

in  { Type = { namespace : Text, displayName : Text, quota : Quota.Type }
    , default.quota = Quota.default
    }
