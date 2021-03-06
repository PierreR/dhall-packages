let List/map = (../../Prelude.dhall).List.map

let Optional/map = (../../Prelude.dhall).Optional.map

let Container = ../schemas/Container.dhall

let openshift = ../packages/openshift.dhall

let makeContainer
    : Container.Type → openshift.Container.Type
    = λ(c : Container.Type) →
        openshift.Container::{
        , name = c.name
        , image = Some c.image
        , env = c.envVars
        , securityContext =
            if    c.runAsRoot || c.runPrivileged
            then  Some
                    openshift.SecurityContext::{
                    , runAsUser = if c.runAsRoot then Some 0 else None Natural
                    , privileged =
                        if c.runPrivileged then Some True else Some False
                    }
            else  None openshift.SecurityContext.Type
        , ports =
            Optional/map
              (List Natural)
              (List openshift.ContainerPort.Type)
              ( List/map
                  Natural
                  openshift.ContainerPort.Type
                  ( λ(port : Natural) →
                      openshift.ContainerPort::{ containerPort = port }
                  )
              )
              c.ports
        , volumeMounts = c.volumeMounts
        , resources = c.resources
        }

in  makeContainer
