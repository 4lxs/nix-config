{ ... }: {
  services.openssh = {
    enable = false;
    settings = {
      # Forbid root login through SSH.
      permitRootLogin = "no";
      # Use keys only. Remove if you want to SSH using password (not recommended)
      passwordAuthentication = false;
    };
  };
}
