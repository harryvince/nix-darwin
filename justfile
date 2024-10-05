install:
    nix run --extra-experimental-features 'nix-command flakes' nix-darwin -- switch --flake .

rebuild:
    darwin-rebuild switch --flake .

list:
    darwin-rebuild --list-generations

clean:
    sudo nix-collect-garbage -d

archive:
    nix flake archive

update:
    nix flake update
