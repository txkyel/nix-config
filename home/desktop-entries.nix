{
  xdg.desktopEntries =
    {
      vesktop = {
        name = "Vesktop";
        exec = "vesktop %U --enable-blink-features=MiddleClickAutoscroll";
        icon = "vesktop";
        genericName = "Internet Messenger";
        categories = [
          "Network"
          "InstantMessaging"
          "Chat"
        ];
        settings = {
          Keywords = "discord;vencord;electron;chat";
          StartupWMClass = "Vesktop";
        };
      };
    }
    // builtins.listToAttrs (
      # Hide desktop entries
      map
        (name: {
          name = name;
          value = {
            name = "";
            noDisplay = true;
          };
        })
        [
          "kbd-layout-viewer5"
          "rofi-theme-selector"
          "xterm"
          # TODO: Find thumbnailer replacement that handles audio/video thumbnailing
          "org.gnome.Totem"
          # fcitx5 desktop entries
          "org.fcitx.fcitx5-migrator"
          "kcm_fcitx5"
        ]
    );
}
