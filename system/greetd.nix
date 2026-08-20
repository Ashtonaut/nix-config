{
  lib,
  pkgs,
  ...
}:

{
  services.greetd = {
    enable = true;
    useTextGreeter = true;
    settings.default_session.command = "${lib.getExe pkgs.tuigreet} --time --remember --asterisks --cmd start-hyprland";
  };
}
