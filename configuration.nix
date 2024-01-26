# This is a Nix configuration file that contains ALL SETTINGS shared by ALL HOSTS:

{ config, pkgs, ... }:

{
  imports =
    [
      ./customOptions.nix
    ];

  ## https://nixos.wiki/wiki/Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  ## 2023-07-22 https://graz.social/@pimeys@social.nauk.io/110757634337893588 -> https://github.com/pimeys/nixos/blob/main/core/default.nix#L73
  ## save space by enabling hard links in the nix store (not a default); And running the optimization once after enabling this setting by doing nix-store --optimise (can take a while). 50-100GB saved right there…
  ## docu: https://nixos.wiki/wiki/Storage_optimization
  nix.settings.auto-optimise-store = true;
  
  # Set your time zone.
  time.timeZone = "US/Pacific";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  systemd.sleep.extraConfig = "HibernateDelaySec=30m"; # from: https://github.com/NixOS/nixos-hardware/issues/672
  
  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.darko = { 
    isNormalUser = true;
    description = "Darko Mesaros"; 
    extraGroups = [
      "wheel" # Enable ‘sudo’ for the user.
      "networkmanager" # Access to networkmanager
    ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      neovim
      git
      # thanks to StellyUK
      ncdu
      openssl
    ];
  };

  security.sudo.extraConfig = ''
                             Defaults        timestamp_timeout=60
  '';                        
  
  programs.zsh.enable = true; # FIXXME: is this redundant to the programs.zsh = {}?

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  environment.variables = {
    EDITOR = "nvim";
    PATH = "$PATH:/home/darko/bin"; # SPECIFICTOKARL
  };

  # Garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    # interval = { Weekday = 0; Hour = 0; Minute = 0; };
    options = "--delete-older-than 30d";
  };

  
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    tmux
    cron
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryFlavor = "gtk2"; 
  };
  services.pcscd.enable = true;  
  


}
