{ pkgs, input, system, ... }:

{

  users.users.darko = {
	home.file.".zshrc".source = ../assets/.config/.zshrc;
	}

}
