{ inputs, pkgs, ... }:
{
    home.stateVersion = "24.11";

    home.packages = with pkgs; [
        ansible
        awscli2
        bat
        cargo
        fd
        gcc
        glow
        gum
        htop
        jq
        just
        lazydocker
        lazygit
        nodejs
        nodePackages.pnpm
        pre-commit
        python3Full
        ripgrep
        rustc
        wget
        zsh-autosuggestions
        zsh-syntax-highlighting
    ];
}
