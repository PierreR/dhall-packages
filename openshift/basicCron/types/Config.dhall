let OpenShift = ../../types/OpenShift.dhall

let Container = ../../types/Container.dhall

in  { Type =
        { name : Text
        , schedule : Text
        , volumes : List OpenShift.Volume.Type
        , configMaps : List OpenShift.ConfigMap.Type
        , secrets : List OpenShift.Secret.Type
        , containers : List Container.Type
        , initContainers : List Container.Type
        }
    , default =
        { volumes = [] : List OpenShift.Volume.Type
        , configMaps = [] : List OpenShift.ConfigMap.Type
        , secrets = [] : List OpenShift.Secret.Type
        , initContainers = [] : List Container.Type
        }
    }
