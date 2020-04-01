let typesUnion
    : Type
    = ./typesUnion.dhall

in  { Type = { apiVersion : Text, kind : Text, items : List typesUnion }
    , default =
        { apiVersion = "v1", kind = "List", items = [] : List typesUnion }
    }
