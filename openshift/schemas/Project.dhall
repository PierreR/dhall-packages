let Quota = ./Quota.dhall

in  { Type =
        { stack : Text
        , projectName : Text
        , zone : Optional Text
        , displayName : Text
        , requester : Text
        , quota : Quota.Type
        }
    , default = { zone = None Text, quota = Quota.default }
    }
