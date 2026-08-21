_:

{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings."*".IdentityAgent = "/run/user/%i/gcr/ssh";
  };
}
