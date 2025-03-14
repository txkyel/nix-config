{pkgs, ...}: {
  home.packages = with pkgs; [
    (google-chrome.override {
      commandLineArgs = [
        "--enable-features=AllowWindowDragUsingSystemDragDrop"
        "--enable-blink-features=MiddleClickAutoscroll"
      ];
    })
  ];

  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    extensions = [
      {id = "bdioigkngoclklbmmgegppmmekffpgdh";}
    ];
    commandLineArgs = [
      "--enable-features=AllowWindowDragUsingSystemDragDrop"
      "--enable-blink-features=MiddleClickAutoscroll"
    ];
  };
}
