{outputs, ...}: {
  nixpkgs = {
    # overlays = [
    #   outputs.overlays.additions
    #   outputs.overlays.modifications
    #   outputs.overlays.stable-packages
    #
    #   # (import (builtins.fetchTarball {
    #   #   sha256 = "1lf3rbgkfskh6g4a6j2x15vwwfrhsdvbii1s4xmp7cwzrh3b2m8a";
    #   #   url = "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";
    #   # }))
    # ];
    # config = {
    #   allowUnfree = true;
    #   # Workaround for https://github.com/nix-community/home-manager/issues/2942
    #   allowUnfreePredicate = _: true;
    # };
  };
}
