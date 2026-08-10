{
  pkgs,
  ...
}:
{
  fonts = {
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      inter
      noto-fonts
      noto-fonts-color-emoji
    ];
    fontconfig.defaultFonts = {
      monospace = [ "JetBrainsMono Nerd Font" ];
      sansSerif = [
        "Inter"
        "Noto Sans"
      ];
      emoji = [ "Noto Color Emoji" ];
    };
  };
}
