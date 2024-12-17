{ homeDir }:
{
  enable = true;
  enableCompletion = true;
  syntaxHighlighting.enable = true;
  autosuggestion.enable = true;
  dotDir = ".config/zsh";

  sessionVariables = {
    SOPS_AGE_KEY_FILE = "$HOME/.sops/age.agekey";
    EDITOR = "nvim";
    DOCKER_BUILDKIT = 0;
    PATH = "$PATH:$HOME/bin";
    DISABLE_AUTO_UPDATE = true;
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
    n = "nnn";
  };

  initExtra = ''
    zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

    export PATH="$PATH:${homeDir}/Library/Python/3.9/bin"
    export PATH="$PATH:/opt/homebrew/bin"
    eval "$(fnm env --use-on-cd --shell zsh)"
    source <(fzf --zsh)

    # oh-my-zsh aliases
    setopt auto_cd
    setopt auto_pushd
    setopt pushd_ignore_dups
    setopt pushdminus


    alias -g ...='../..'
    alias -g ....='../../..'
    alias -g .....='../../../..'
    alias -g ......='../../../../..'

    alias -- -='cd -'
    alias 1='cd -1'
    alias 2='cd -2'
    alias 3='cd -3'
    alias 4='cd -4'
    alias 5='cd -5'
    alias 6='cd -6'
    alias 7='cd -7'
    alias 8='cd -8'
    alias 9='cd -9'

    alias md='mkdir -p'
    alias rd=rmdir

    function d () {
      if [[ -n $1 ]]; then
        dirs "$@"
      else
        dirs -v | head -n 10
      fi
    }
    compdef _dirs d

    # List directory contents
    alias lsa='ls -lah'
    alias l='ls -lah'
    alias ll='ls -lh'
    alias la='ls -lAh'
  '';

  history = {
    size = 100000;
    share = true;
    path = "${homeDir}/.config/zsh/history";
  };
}
