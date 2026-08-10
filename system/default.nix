{
  lib,
  ...
}:

{
  imports = builtins.filter (
    filename: lib.hasSuffix ".nix" (toString filename) && baseNameOf filename != "default.nix"
  ) (lib.filesystem.listFilesRecursive ./.);

  age.identityPaths = [ "/etc/agenix/key.txt" ];

  system.stateVersion = "25.11";
}
