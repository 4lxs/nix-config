{ pkgs, ... }: {
  home.packages = with pkgs; [ firefox ];
  programs.firefox = {
    # firefox = {
    #   enable = true;
    #   profiles.svl = {
    #     name = "svl";
    #     userChrome = ''
    #     '';
    #   };
    # };
  };
}
