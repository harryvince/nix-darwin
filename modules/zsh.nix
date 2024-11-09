{ homeDir }:
{
  enable = true;
  enableCompletion = true;
  syntaxHighlighting.enable = true;
  autosuggestion.enable = true;
  dotDir = ".config/zsh";

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
    l = "ls -lah";
  };

  initExtra = ''
    export PATH="$PATH:${homeDir}/Library/Python/3.9/bin"
  '';

  history = {
    size = 100000;
    share = true;
    path = "${homeDir}/.config/zsh/history";
  };
}
