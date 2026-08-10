{
  config,
  ...
}:

{
  age.secrets."ashtonaut.hash".file = ../secrets/ashtonaut.hash.age;

  users = {
    mutableUsers = false;
    users.ashtonaut = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      hashedPasswordFile = config.age.secrets."ashtonaut.hash".path;
    };
  };
}
