let schemas =
      ./schemas/schemas.dhall sha256:e668154c2a1ee4b83b80f681c21aa182410259ece5e973a9b44c8cfa7ea06552

let openshift =
      { core =
          ./packages/openshift.dhall sha256:96816d3c8c688ab47918f5403b6b465ee087044ffe2d8c6c0ff4bdddf8b9974e
      }

let func =
      ./func/func.dhall sha256:15b67ac788661576de32c8ca7a216010be476f517f91f55cba9d0c67a2d26fe6

in  openshift ∧ schemas ∧ func
