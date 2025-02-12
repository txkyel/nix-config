{
    xdg.desktopEntries = {
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
    };
}
