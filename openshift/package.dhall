let schemas =
      ./schemas/schemas.dhall sha256:8fc8c922fd445eac8557b217d6bb855f2e28c76808c27b4a17fdeda7238c0b62

let openshift =
      { core =
          ./packages/openshift.dhall sha256:96816d3c8c688ab47918f5403b6b465ee087044ffe2d8c6c0ff4bdddf8b9974e
      }

let func =
      ./func/func.dhall sha256:c6aa54af068ecf1fa027e628120f5b8ee7c499f8457c5836c8c1a5e826b48aab

in  openshift ∧ schemas ∧ func
