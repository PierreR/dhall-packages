{ Type =
    { targetPort : Natural, protocol : Text, enableTLS : Bool, type : Text }
, default = { protocol = "TCP", enableTLS = False, type = "ClusterIP" }
}
