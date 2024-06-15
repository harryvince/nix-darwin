{ inputs, pkgs, ... }:
{
    home.stateVersion = "24.11";

    home.packages = with pkgs; [
        ansible
        awscli2
        bat
        cargo
        fd
        fnm
        gcc
        glow
        gum
        htop
        jq
        just
        lazydocker
        lazygit
        pre-commit
        process-compose
        python3Full
        ripgrep
        rustc
        turso-cli
        wget
        zsh-autosuggestions
        zsh-syntax-highlighting
    ];

    programs.fzf.enable = true;
    programs.git = {
        enable = true;
        userName = "harryvince";
        userEmail = "harryavince@gmail.com";
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
            plugins = ["git" "ssh-agent" "fnm" "fzf" "z"];
            theme = "robbyrussell";
        };

        shellAliases = {
            wt = "git worktree";
            lg = "lazygit";
            pi5="ssh pi5.vince.io";
            tf="terraform";
            python="python3";
            brew-update="brew update && brew upgrade && brew autoremove && brew cleanup -s && brew cleanup --prune=all";
            ldo="lazydocker";
        };

        initExtra = ''
            eval $(fnm env)
            export EDITOR="nvim"
            source ~/.iterm2_shell_integration.zsh
        '';
    };

    programs.direnv = {
        enable = true;
        enableZshIntegration = true;
        nix-direnv.enable = true;
    };
}
