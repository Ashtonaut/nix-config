{
  lib,
  ...
}:

{
  imports = builtins.filter (
    filename: lib.hasSuffix ".nix" (toString filename) && baseNameOf filename != "default.nix"
  ) (lib.filesystem.listFilesRecursive ./.);

  home.stateVersion = "25.11";
}
