let openshift = ../packages/openshift.dhall

let Container = ../schemas/Container.dhall

in  { Type =
        { name : Text
        , schedule : Text
        , volumes : List openshift.Volume.Type
        , configMaps : List openshift.ConfigMap.Type
        , secrets : List openshift.Secret.Type
        , containers : List Container.Type
        , initContainers : List Container.Type
        }
    , default =
        { volumes = [] : List openshift.Volume.Type
        , configMaps = [] : List openshift.ConfigMap.Type
        , secrets = [] : List openshift.Secret.Type
        , initContainers = [] : List Container.Type
        }
    }
