{ inputs, outputs, lib, config, pkgs, ... }:
let
    python-packages = ps: with ps; [
        jupyter
        ipython
        pandas
        numpy
        matplotlib
        pynvim
    ];
in {
    home.packages = with pkgs; [
        (python3.withPackages python-packages)
    ];
}
