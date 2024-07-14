{ inputs, pkgs, ... }:
{
    home.stateVersion = "24.11";

    home.packages = with pkgs; [
        age
        ansible
        awscli2
        bat
        buf
        cargo
        fd
        fluxcd
        fnm
        fpm
        gcc
        glow
        go
        golangci-lint
        gum
        htop
        jq
        just
        k9s
        kubectl
        kubernetes-helm
        lazydocker
        lazygit
        pre-commit
        process-compose
        protoc-gen-go-grpc
        python3Full
        ripgrep
        rustc
        sops
        turso-cli
        unixtools.watch
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

        sessionVariables = {
            SOPS_AGE_KEY_FILE = "$HOME/.sops/age.agekey";
        };

        shellAliases = {
            wt = "git worktree";
            lg = "lazygit";
            pi5="ssh pi5.vince.io";
            kpi5="kubectl config use-context pi5";
            pi4="ssh pi4.vince.io";
            kpi4="kubectl config use-context pi4";
            tf="terraform";
            python="python3";
            brew-update="brew update && brew upgrade && brew autoremove && brew cleanup -s && brew cleanup --prune=all";
            ldo="lazydocker";
        };

        initExtra = ''
            eval $(fnm env)
            source ~/.iterm2_shell_integration.zsh
        '';
    };

    programs.direnv = {
        enable = true;
        enableZshIntegration = true;
        nix-direnv.enable = true;
    };
}
