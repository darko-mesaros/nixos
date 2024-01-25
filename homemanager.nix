{ config, pkgs, lib, inputs, ... }:

{

  # FIXXME: move stateVersion to either host-specific spot in flake.nix or hosts/$HOSTNAME/default.nix
  # causes:
  # trace: warning: system.stateVersion is not set, defaulting to 23.05. Read why this matters on https://nixos.org/manual/nixos/stable/options.html#opt-system.stateVersion.
  home.stateVersion = "23.11";

  nixpkgs.config.allowUnfree = true;   # e.g. for  vscode
#    nixpkgs.config.permittedInsecurePackages = [ "xpdf-4.04" ];

  home.packages = with pkgs; [
    hicolor-icon-theme
    inputs.nh.packages.${pkgs.system}.default
    nodejs_20
    # flex on nerds Piq9117
    neofetch
  ];

  home.sessionVariables.FLAKE = "/home/darko/nixos"; ## for nh
  
  xdg = {
    enable = true;
  };


}
