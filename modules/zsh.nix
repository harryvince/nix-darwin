{ homeDir }:
{
  enable = true;
  enableCompletion = true;
  syntaxHighlighting.enable = true;
  autosuggestion.enable = true;
  autocd = true;
  dotDir = ".config/zsh";

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
    autoload -U colors && colors
    zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

    git_dirty_indicator() {
      if [[ $(git status --porcelain 2>/dev/null) ]]; then
        echo "*"
      fi
    }

    root_folder_name() {
      basename "$PWD"
    }

    setopt prompt_subst
    PROMPT='$(if [[ $(git rev-parse --is-inside-work-tree 2>/dev/null) == true ]]; then
      echo "%F{cyan}$(root_folder_name)%f %F{white}[%F{red}$(git branch --show-current)%F{yellow}$(git_dirty_indicator)%F{white}]%f";
    else
      echo "%F{cyan}''${PWD/#$HOME/~}%f";
    fi) %F{yellow}❯%f '

    eval "$(fnm env --use-on-cd --shell zsh)"
    source <(fzf --zsh)
  '';

  history = {
    size = 100000;
    share = true;
    path = "${homeDir}/.config/zsh/history";
  };
}
