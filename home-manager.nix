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
        python3Full
        ripgrep
        rustc
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

    programs.neovim.enable = true;
}
