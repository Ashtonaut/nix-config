{
  config,
  ...
}:

{
  age.secrets = {
    "eduroam.env".file = ../secrets/eduroam.env.age;
    "home-wifi.env".file = ../secrets/home-wifi.env.age;
  };

  networking = {
    hostName = "ashtonaut-laptop";
    networkmanager = {
      enable = true;
      ensureProfiles = {
        environmentFiles = [
          config.age.secrets."eduroam.env".path
          config.age.secrets."home-wifi.env".path
        ];
        profiles.eduroam = {
          connection = {
            id = "eduroam";
            type = "wifi";
            autoconnect = true;
          };
          wifi = {
            mode = "infrastructure";
            ssid = "eduroam";
          };
          wifi-security = {
            key-mgmt = "wpa-eap";
          };
          "802-1x" = {
            eap = "peap";
            phase2-auth = "mschapv2";
            anonymous-identity = "anonymous@leeds.ac.uk";
            identity = "$EDUROAM_IDENTITY";
            password = "$EDUROAM_PASSWORD";
            ca-cert = "${../certs/leeds-eduroam-ca.pem}";
            domain-suffix-match = "radius.leeds.ac.uk";
          };
          ipv4.method = "auto";
          ipv6.method = "auto";
        };
        profiles.home-wifi = {
          connection = {
            id = "home-wifi";
            type = "wifi";
            autoconnect = true;
          };
          wifi = {
            mode = "infrastructure";
            ssid = "$HOME_WIFI_SSID";
          };
          wifi-security = {
            key-mgmt = "wpa-psk";
            psk = "$HOME_WIFI_PASSWORD";
          };
          ipv4.method = "auto";
          ipv6.method = "auto";
        };
      };
    };
  };
}
