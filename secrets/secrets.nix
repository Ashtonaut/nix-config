let
  host = "age18pj35xlq87fw67xpuzwt5l4ldmmzcqyr5cmtx6g0cjufs30etpns6m5yrf";
  ashtonaut = "age1u49jcvktgy9xc7xc3v9wk2567zufjj0v0d4xr782t9j04c5nyyrq3j0qef";
  all = [
    host
    ashtonaut
  ];
in
{
  "secrets/ashtonaut.hash.age".publicKeys = all;
  "secrets/eduroam.env.age".publicKeys = all;
  "secrets/home-wifi.env.age".publicKeys = all;
}
