let schemas = ./schemas/schemas.dhall

let openshift = { core = ./packages/openshift.dhall }

let func = ./func/func.dhall

in  openshift ∧ schemas ∧ func
