let openshift = ../packages/openshift.dhall

let Container = ../schemas/Container.dhall

in  { Type =
        { replicas : Natural
        , containers : List Container.Type
        , volumes : Optional (List openshift.Volume.Type)
        }
    , default.volumes = None (List openshift.Volume.Type)
    }
