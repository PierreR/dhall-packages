let schemas =
      ./schemas/schemas.dhall sha256:99e7d7610fe333212f056775de6c5e8f032dcca968e4c290fcd7b12d252870dd

let func =
      ./func/func.dhall sha256:1906c22d87d794ab6f4c0363ee8bb77950889e6f178c6d1ad2290f9e20a50450

in  func ∧ schemas
