let Container = ./types/Container.dhall

let OpenShift = ./types/OpenShift.dhall

let Prelude = ./types/Prelude.dhall

let makeContainer
    : Container.Type → OpenShift.Container.Type
    =   λ(c : Container.Type)
      → OpenShift.Container::{
        , name = c.name
        , image = Some c.image
        , env = c.envVars
        , securityContext =
                  if c.runAsRoot || c.runPrivileged

            then  Some
                    OpenShift.SecurityContext::{
                    , runAsUser = if c.runAsRoot then Some 0 else None Natural
                    , privileged =
                        if c.runPrivileged then Some True else Some False
                    }

            else  None OpenShift.SecurityContext.Type
        , ports =
            Prelude.map
              Natural
              OpenShift.ContainerPort.Type
              (   λ(port : Natural)
                → OpenShift.ContainerPort::{ containerPort = port }
              )
              c.ports
        , volumeMounts = c.volumeMounts
        }

in  makeContainer
