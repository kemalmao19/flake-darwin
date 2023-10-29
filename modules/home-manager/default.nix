{ pkgs, nixvim, ... }: {
  # Don't change this when you change package input. Leave it alone.
  home.stateVersion = "23.05";
  home.sessionVariables = {
    PAGER = "less";
    CLICLOLOR = 1;
    EDITOR = "hx";
  };
  
  # specify my home-manager configs
  # App bundle
  home.packages = with pkgs; [
    #  ripgrep
    vscodium
    exa
    trash-cli
    ranger
    neofetch
    bottom
    bat
    # cava
    nixfmt
    # spotify
    #  fd
    #  curl
    #  less
    
  ];

  imports = [
    #./packages/helix.nix 
    # ./packages/zsh.nix
    ./packages/alacritty.nix
    ./packages/fish.nix
    ./packages/tmux.nix
    ./packages/fzf.nix
    ./packages/starship.nix
    ./packages/zoxide.nix
    ./packages/git.nix
    ./packages/nvim.nix
    #./packages/nixvim.nix
    # ./packages/shell.nix
    ./packages/starship-symbol.nix
  ];
  # dotfiles
  home.file.".inputrc".source = ./dotfiles/inputrc;
}
