{ config, pkgs, lib, hostName, ... }:

{

    home.packages = with pkgs; [
      fnm                                                 # node version manager
      rustc			                                          # rust compiler
      cargo			                                          # rust package manager
      python311Full		                                    # python 3.11
      lua			                                            # lua interpreter
      jq			                                            # json query processor
      ruby			                                          # ruby
      gccgo                                               # gnu compiler collection
      glibc                                               # gnu c library

      # lsp - mainly for neovim
      asm-lsp                                             # asm_lsp
      nil                                                 # nil_ls
      lua-language-server                                 # lua_ls
      nodePackages_latest.vscode-css-languageserver-bin   # cssls
      nodePackages_latest.vscode-html-languageserver-bin  # html
      nodePackages_latest.typescript-language-server      # tsserver
      nodePackages_latest.pyright                         # pyright
      python311Packages.python-lsp-server                 # pylsp
      nodePackages_latest.bash-language-server            # bashls
      nodePackages_latest.vscode-json-languageserver-bin  # jsonls
      yaml-language-server                                # yamlls
      marksman                                            # marksman
      llvmPackages_14.clang-unwrapped                     # clangd
      terraform-ls                                        # terraformls
      rust-analyzer                                       # rust_analyzer

      # rust
      bacon
      clippy
      
      ];

}
