{
    time.timeZone = "America/Toronto";
    # This currently does not work
    #services.localtimed.enable = true;

    i18n.defaultLocale = "en_US.UTF-8";
    services.xserver = {
        enable = true;
        xkb.layout = "us";
    };
}

