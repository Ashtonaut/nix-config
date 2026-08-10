{
  pkgs,
  ...
}:

let
  screenshot = pkgs.writeShellApplication {
    name = "screenshot";
    runtimeInputs = [
      pkgs.grim
      pkgs.slurp
      pkgs.wl-clipboard
    ];
    text = ''
      dir="$HOME/Pictures/Screenshots"
      mkdir -p "$dir"
      file="$dir/$(date +'%Y-%m-%d_%H-%M-%S').png"

      case "''${1-}" in
        region) grim -g "$(slurp)" - | tee "$file" | wl-copy ;;
        full) grim - | tee "$file" | wl-copy ;;
        *)
          echo "usage: screenshot {region|full}" >&2
          exit 1
          ;;
      esac
    '';
  };
in
{
  home.packages = [ screenshot ];
}
