{
  pkgs,
  ...
}:

{
  home.packages = [
    pkgs.claude-code
    pkgs.brightnessctl
    pkgs.libnotify
  ];
}
