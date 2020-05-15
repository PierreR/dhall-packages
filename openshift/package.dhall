let schemas =
      ./schemas/schemas.dhall sha256:8fc8c922fd445eac8557b217d6bb855f2e28c76808c27b4a17fdeda7238c0b62

let openshift =
      { core =
          ./packages/openshift.dhall sha256:96816d3c8c688ab47918f5403b6b465ee087044ffe2d8c6c0ff4bdddf8b9974e
      }

let func =
      ./func/func.dhall sha256:5daf0001ed538a149a2774816e46a4d8826d5950a379de04f6fdc67182506dc1

in  openshift ∧ schemas ∧ func
