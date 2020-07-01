let openshift = ../packages/openshift.dhall

let roleBinding =
      λ(stack : Text) →
      λ(namespace : Text) →
        let roleRef =
              openshift.RoleRef::{
              , apiGroup = "rbac.authorization.k8s.io"
              , kind = "ClusterRole"
              , name = "edit"
              }

        let subject =
              openshift.Subject::{
              , kind = "ServiceAccount"
              , name = stack
              , namespace = Some "default"
              }

        in  openshift.RoleBinding::{
            , metadata = openshift.ObjectMeta::{
              , name = Some (stack ++ "-sa-edit")
              , namespace = Some namespace
              }
            , roleRef
            , subjects = Some [ subject ]
            }

in  roleBinding
