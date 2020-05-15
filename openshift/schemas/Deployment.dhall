let openshift = ../packages/openshift.dhall

let Container = ../schemas/Container.dhall

in  { Type =
        { replicas : Natural
        , containers : List Container.Type
        , volumes : List openshift.Volume.Type
        }
    , default.volumes = [] : List openshift.Volume.Type
    }
