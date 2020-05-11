let ocp =
      ../package.dhall sha256:ab5abf098ad2136c82d7157f8aa1b63f562275e8a8350375753ab579bf6b6b69

in  ocp.makeQuota "quota1" ocp.Quota::{=}
