let Openshift =
      https://raw.githubusercontent.com/TristanCacqueray/dhall-openshift/master/package.dhall sha256:422477ee4999e20e3aa0486f9b25c5728e7e266d42b143b53578eff44e92f009

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
