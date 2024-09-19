{ pkgs, ... }: {
  # Don't change this when you change package input. Leave it alone.
  home.stateVersion = "23.05";
  home.sessionVariables = {
    PAGER = "less";
    CLICLOLOR = 1;
    EDITOR = "nvim";
  };

  # specify my home-manager configs
  # App bundle
  home.packages = with pkgs; [
    vscodium
    exa
    trash-cli
    ranger
    neofetch
    freshfetch
    bottom
    bat
    nixfmt
    ripgrep
    fd
  ];

  imports = [
    ./packages/helix.nix
    # ./packages/zsh.nix
    # ./packages/alacritty.nix
    ./packages/fish.nix
    ./packages/tmux.nix
    ./packages/fzf.nix
    ./packages/starship.nix
    ./packages/zoxide.nix
    ./packages/git.nix
    ./packages/neovim
    ./packages/starship-symbol.nix
  ];
  # dotfiles
  home.file.".inputrc".source = ./dotfiles/inputrc;
}
