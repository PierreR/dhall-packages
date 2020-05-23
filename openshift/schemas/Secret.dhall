let openshift = ../packages/openshift.dhall

in  { Type = openshift.Secret.Type ⩓ { name : Text }
    , default =
          openshift.Secret.default
        ⫽ { type = Some "Opaque", metadata = openshift.ObjectMeta::{=} }
    }
