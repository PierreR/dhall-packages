let c =
      { Type =
          { name : Text, path : Text, repository : Text, argoPlugin : Text }
      , default = { argoPlugin = "encrypted-yaml", path = "./" }
      }

in  c
