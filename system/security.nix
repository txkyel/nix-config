{
    security = {
        pam.services.swaylock.text = "auth include login";
        polkit.enable = true;
        polkit.extraConfig = ''
            polkit.addRule(function(action, subject) {
                if ((action.id == "org.corectrl.helper.init" ||
                     action.id == "org.corectrl.helperkiller.init") &&
                    subject.local == true &&
                    subject.active == true &&
                    subject.isInGroup("users")) {
                        return polkit.Result.YES;
                }
            });
        '';
    };
}
