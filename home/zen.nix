{
  inputs,
  ...
}:

{
  imports = [ inputs.zen-browser.homeModules.beta ];

  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;

    policies = {
      DontCheckDefaultBrowser = true;

      Preferences = {
        "media.hardware-video-decoding.force-enabled" = {
          Value = true;
          Status = "default";
        };
      };
    };
  };
}
