let packages = ./packages/dhall-packages.dhall

let argocd = ./packages/argocd.dhall

let schemas = ./schemas/schemas.dhall

let func = ./func/func.dhall

in  packages ∧ argocd ∧ func ∧ schemas
