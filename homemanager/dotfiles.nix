{ pkgs, input, system, config, ... }:

{
  # ZSH
  home.file.".zshrc".source = ../assets/.config/.zshrc;
  # ranger
  home.file.".config/ranger" = {
  	source = ../assets/.config/ranger;
	recursive = true;
  };
  # neovim
  home.file.".config/nvim" = {
  	source = config.lib.file.mkOutOfStoreSymlink /home/darko/nixos/assets/.config/nvim;
	  recursive = true;
  };
}
