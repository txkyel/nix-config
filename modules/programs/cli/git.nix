{
  config = {
    programs.git = {
      enable = true;
      lfs.enable = true;
      config = {
        user = {
          email = "kylexiao20@gmail.com";
          name = "Kyle Xiao";
        };
        signing.format = "ssh";
      };
    };
  };
}
