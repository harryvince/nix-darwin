{ inputs, pkgs, ... }:
{
  home.stateVersion = "24.11";

  home.packages = import ./pkgs.nix { inherit pkgs; };

  home.file = {
    bin = {
      source = ./bin;
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

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "ssh-agent" "fnm" "fzf" "z" ];
      theme = "robbyrussell";
    };

    sessionVariables = {
      SOPS_AGE_KEY_FILE = "$HOME/.sops/age.agekey";
      EDITOR = "neovim";
      DOCKER_BUILDKIT = 0;
      PATH = "$PATH:$HOME/bin";
      # DOCKER_HOST = "unix:///$(podman machine inspect --format '{{.ConnectionInfo.PodmanSocket.Path}}')";
    };

    shellAliases = {
      wt = "git worktree";
      lg = "lazygit";
      pi5 = "ssh pi5.vince.io";
      kpi5 = "kubectl config use-context pi5";
      pi4 = "ssh pi4.vince.io";
      kpi4 = "kubectl config use-context pi4";
      tf = "terraform";
      python = "python3";
      brew-update = "brew update && brew upgrade && brew autoremove && brew cleanup -s && brew cleanup --prune=all";
      ldo = "lazydocker";
      m = ". $HOME/bin/mono";
      # docker = "podman";
    };

    initExtra = ''
      export PATH="$PATH:/Users/harry/Library/Python/3.9/bin"
    '';
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
}
