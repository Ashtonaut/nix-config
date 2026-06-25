let
  host = "age18pj35xlq87fw67xpuzwt5l4ldmmzcqyr5cmtx6g0cjufs30etpns6m5yrf";
in {
  "secrets/ashtonaut.hash.age".publicKeys = [ host ];
  "secrets/eduroam.env.age".publicKeys = [ host ];
}
