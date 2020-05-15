-- Minimal resources built from an 'application-form'
let Quota = ../schemas/Quota.dhall

let Project = ../schemas/Project.dhall

in  { Type = { project : Project, quota : Quota.Type }
    , default.quota = Quota.default
    }
