{ pkgs, homeDir, ... }:
{
  home.stateVersion = "24.11";

  home.packages = import ./pkgs.nix { inherit pkgs; };

  home.file = {
    bin = {
      source = ../bin;
      recursive = true;
    };
  };

  programs.fzf.enable = true;
  programs.git = {
    enable = true;
    userName = "harryvince";
    userEmail = "harryavince@gmail.com";
    extraConfig = {
      diff = { external = "${pkgs.difftastic}/bin/difft"; };
    };
  };

  # programs.starship = {
  #   enable = true;
  # };

  programs.lazygit = {
    enable = true;
    settings = {
      git = {
        overrideGpg = true;
        paging.externalDiffCommand = "${pkgs.difftastic}/bin/difft --color=always --display=inline --syntax-highlight=on --tab-width=2";
      };
    };
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };

  programs.zsh = import ./zsh.nix { inherit homeDir; };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
}
