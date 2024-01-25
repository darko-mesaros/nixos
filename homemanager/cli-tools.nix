{ config, pkgs, lib, hostName, ... }:

{

    home.packages = with pkgs; [

      zsh
      thefuck
      grml-zsh-config
      htop
      dnsutils
      mc  #midnight commander
      nmap
      whois
      pmutils
      lsof
      usbutils
      hwinfo
      iotop
      fuse
      ddrescue
      hddtemp
      hdparm
      hwdata
      acpi
      rsync
      traceroute
      util-linux
      vpnc
      vnstat
      file
      pciutils
      ncftp
      socat
      cryptsetup

      # NixOS
      nix-index  # "locate/grep" for files in all nix packages
      comma      # temporarily installing packages in current shell

      
      # file management
      eza
      wget
      aria2
      moreutils ## vidir from perl534Packages.vidir doesn't sort output: id:2023-11-10-fix-wrong-order-in-vidir
      xdg-utils
      dos2unix
      mmv
      less
      mktemp
      pwgen
      inotify-tools

      # backups
      rsnapshot

      # ssh
      sshuttle
      ssh-askpass-fullscreen
      autossh
 
      # text UI
      dialog
      ncurses

      # tmux
      tmuxp

      # git
      tig
      git
      
      # compression/decompression tools
      zip
      unzip
      unp
      bzip2
      gzip
      rar
      gnutar
      p7zip

# diff tools
      wdiff
      diffpdf
      diffutils
      delta # "A syntax-highlighting pager for git" https://github.com/dandavison/delta
      
      # search
      silver-searcher
      ack
      fzf
      fd  # fd is a simple, fast and user-friendly alternative to find(1).
      findutils
      zsh-z  # https://github.com/agkozak/zsh-z -> "Zsh-z is a native Zsh port of rupa/z, a tool written for bash and Zsh that uses embedded awk scripts to do the heavy lifting."
      rdfind
      ripgrep

      # email
      mutt

      # QMK
      qmk
      qmk-udev-rules

      # spellchecker
      aspell aspellDicts.de aspellDicts.en aspellDicts.en-computers
     
      ocrmypdf
      yt-dlp
      youtube-dl
      jq ## used for yth.sh
      magic-wormhole
      pdfminer  # e.g. for pdf2txt dumppdf
      qpdf  # e.g. splitting pdf files
    ];


  # WORKS:
  # home.file.".tmuxp/nixosvmr".source = ../assets/.tmuxp/nixosvmr.yaml; # with hard-coded hostname


    programs.zsh = {
      

      enable = true;
    };  # end of ZSH

    programs.git = {
      enable = true;
      userName  = "darko-mesaros"; # SPECIFICTOKARL
      userEmail = "darko.subotica@gmail.com"; # SPECIFICTOKARL
      aliases = {
        lol = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset' --abbrev-commit";
        ci = "commit";
        co = "checkout";
        s = "status";
      };
    }; # end of git

  

    programs.mpv = {

      # all options: https://rycee.gitlab.io/home-manager/options.html#opt-programs.mpv.enable
      
      enable = true;
      config = {

        # Type: attribute set of (string or signed integer or boolean
        # or floating point number or list of (string or signed
        # integer or boolean or floating point number))
        
        osd-bar-align-y = 1;
        osd-duration = 2000;
        osd-on-seek = "msg-bar";
        keep-open = "yes";
        script-opts = "ytdl_hook-ytdl_path=/usr/local/bin/yt-dlp;";
      };

      
    }; # mpv
