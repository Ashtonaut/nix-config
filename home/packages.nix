{
  pkgs,
  ...
}:

{
  home.packages = [
    pkgs.claude-code
    pkgs.libnotify
    pkgs.moonlight-qt
  ];
}
