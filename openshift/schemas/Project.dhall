let Quota = ../schemas/Quota.dhall

in  { Type =
        { name : Text
        , displayName : Text
        , requester : Text
        , quota : Quota.Type
        }
    , default.quota = Quota.default
    }
