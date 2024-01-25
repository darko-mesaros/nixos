# NixOS Configuration With Flakes, Home-manager

> This Repo was started and inspired by a [blog post](https://karl-voit.at/2023/09/12/nix/) by the amazing Karl Voit. Make sure to check out the blog post AND his [GitHub repo](https://github.com/novoid/nixos-config) for more awesomness! 

## Basic Concept

My setup is using the `flake.nix` as a central point.

`flake.nix` is calling most of the other files depending on
the set hostname:

- `hosts/$HOSTNAME/default.nix`
- `configuration.nix`
- all files related to `home-manager`: `homemanager.nix` and `homemanager/*`

The directory `assets` contain various configuration and binary files I wanted to keep close to my NixOS configuration files.

## Installation

1. Download installer ISO
    - [https://nixos.org/download.html#nixos-iso]([https://nixos.org/download.html#nixos-iso)
2. Install NixOS using that ISO
    - Learn how to set up a USB thumb drive and boot from it for installing the basic OS
3. Modify default configuration.nix:
    1. Start an editor:
        ``` example
        sudo nano /etc/nixos/configuration.nix
        ```
    2. Change hostname on new host from default if necessary:
        - [https://borretti.me/article/nixos-for-the-impatient#postinstall](https://borretti.me/article/nixos-for-the-impatient#postinstall)
            - by setting `networking.hostName` from "nixos" to a new hostname
    3. Activate flakes: [https://nixos.wiki/wiki/Flakes](https://nixos.wiki/wiki/Flakes)
        - On NixOS set the following options in `configuration.nix` and run `nixos-rebuild`
        ``` nix
        { pkgs, ... }: {   # usual, this line is already there

          nix.settings.experimental-features = [ "nix-command" "flakes" ];

        }                  # usual, this line is already there
        ```
    4. Add the `git` and package. Also add your favourite editor as well for fixing miscellaneous things. I'm using `vim` for that.
        - Just write [the corresponding package name](https://search.nixos.org/packages) where `firefox` is installed in the `configuration.nix`.
    5. Update and activate your setup
        ``` example
        sudo nixos-rebuild switch
        ```
4. Clone this Git repo to `~/nixos/`: `git clone https://github.com/novoid/nixos-config.git ~/nixos`
5. Create a configuration for the `$HOSTNAME` in the nixos-configuration git repo
    1. Adapt `flakes.nix`
    2. Create `~/nixos/hosts/$HOSTNAME` (from the `DEFAULT` host as template)
    3. Get the `hardware-configuration.nix` into your new setup
        ```bash
        cd ~/nixos
        cp /etc/nixos/hardware-configuration.nix ~/nixos/hosts/$HOSTNAME/
        cp /etc/nixos/configuration.nix ~/nixos/hosts/$HOSTNAME/default.nix
        git add 
        ```
6. Run flakes with the new setup:
    1. Switch to nixos-config dir
    2. Double-check: make sure that hostname matches a config
    3. Run flakes with current nixos-config dir:
        ``` example
        sudo nixos-rebuild switch --flake .
        ```
    4. Fix any error that may arise at this point.

        - Yes, this can be frustrating. I wish you good luck here.
        - Usually, you just have to remove stuff from `~/nixos/hosts/$HOSTNAME/default.nix` when it is also defined in `flakes.nix` or other existing files.
        - Futhermore, you might have to create (and `git add`) configuration files that are assumed to exist such as `assets/.tmuxp/$HOSTNAME.yaml`.
    5. I do recommend a reboot here to cleanly boot the updated OS with all of its settings.

    6. Execute store optimization (replacing copies with hardlinks):
        ``` example
        nix-store --optimise
        ```
    7. OPTIONALLY: Symlink `/etc/nixos` to `~/nixos` if you want to use `nixos-rebuild` without the optional parameter for the path.

## License

If not specified otherwise, this configuration is licensed under a [Creative Commons Attribution-ShareAlike 4.0 International License](http://creativecommons.org/licenses/by-sa/4.0/)
