install:
    nix run --extra-experimental-features 'nix-command flakes' nix-darwin -- switch --flake .

rebuild:
    darwin-rebuild switch --flake .
