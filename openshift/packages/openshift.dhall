let Openshift =
      https://raw.githubusercontent.com/TristanCacqueray/dhall-openshift/v0.2.0/package.dhall sha256:5d6efe2ed15b3e4e263bafce9752c45c671a42bbefd4d483e87d40d41d089640

in    Openshift
    ∧ { List =
        { Type =
            { apiVersion : Text, kind : Text, items : List Openshift.Resource }
        , default =
          { apiVersion = "v1"
          , kind = "List"
          , items = [] : List Openshift.Resource
          }
        }
      }
