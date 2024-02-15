{ pkgs, ... }:
let
  python-packages = ps: with ps; [
    jupyter
    ipython
    pandas
    numpy
    matplotlib
    pynvim
    python-dotenv
    requests
    pynvim
    prompt-toolkit
  ];
in
{
  home.packages = with pkgs; [
    (python311.withPackages python-packages)
  ];
}
