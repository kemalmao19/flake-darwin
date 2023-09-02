{ pkgs, ... }: {
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
    git
    exa
    trash-cli
    ranger
    neofetch
    bottom
    # cava
    nixfmt
    # spotify
    #  fd
    #  curl
    #  less
    #  pwnvim.packages."aarch64-darwin".default

    # Python environment
    (python310.withPackages (ps:
      with ps; [
        # IDE
        jupyterlab
        ipython
        ipykernel

        # Spyder IDE
        # spyder
        # spyder-kernels

        # DS
        pandas
        matplotlib
        numpy
        # plotly
        scikit-learn-extra
        scipy
        # seaborn

        # probabilistic
        # pymc

        # formatter
        black

        # other
        # virtualenv
      ]))
  ];

  programs.bat = {
    enable = true;
    config.theme = "TwoDark";
  };

  programs.git = {
    enable = true;
    userName = "kemalmao19";
    userEmail = "sebelumtidur14@gmail.com";
  };

  # programs.helix = {
  #   enable = true;
  #   settings = {
  #     theme = "tokyonight";
  #     editor = {
  #       line-number = "relative";
  #       lsp.display-messages = true;
  #     };
  #     keys.normal = {
  #       space.space = "file_picker";
  #       space.w = ":w";
  #       space.q = ":q";
  #       esc = [ "collapse_selection" "keep_primary_selection" ];
  #     };
  #   };
  # };

  imports = [ ./helix.nix ];

  programs.tmux = {
    enable = true;
    # enableMouse = true;
    # enableSensible = true;
    plugins = with pkgs;
      [
        #tmuxPlugins.catppuccin
        tmuxPlugins.power-theme
      ];

    extraConfig = ''

      set -g status off

      # COLORS
      bg_color='#282c34'

      # BORDERS COLOR
      set -g pane-border-style "fg=$bg_color bg=$bg_color"
      set -g pane-active-border-style "fg=$bg_color bg=$bg_color"
      set -sg escape-time 10 
    '';

  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    shellAliases = {
      ls = "ls --color=auto -F";
      nixswitch = "darwin-rebuild switch --flake .#";
      nixup = "pushd ~/src/system-config; nix flake update; nixswitch; popd";
    };

    localVariables = {
      vivid_theme = "catppuccin-macchiato";
    };
    
    plugins = [
      {
        name = "ohmyzsh-macos";
        file = "plugins/macos.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "ohmyzsh";
          repo = "ohmyzsh";
          rev = "c4392a4da31efee36f29a62d3951d5c0fcd7d4e6";
          sha256 = "sha256-cMJCmhtcCAVDFgp6Ryv/5DteSRtwNcemO97as8ill8I=";
        };
      }
      {
        name = "vivid-zsh";
        src = pkgs.fetchFromGitHub {
          owner = "ryanccn";
          repo = "vivid-zsh";
          rev = "a76616c87821e96ae0cbdfb6bf897bffc170a283";
          sha256 = "sha256-E00xQMCmOt6fJ+IO/TrpFvskNa9QnDw/6DKR51T7i+8=";
        };
      }
    ];
  };

  programs.fish = {
    enable = true;
    shellAbbrs = {
      cp = "cp -iv";
      mv = "mv -iv";
    };
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableZshIntegration = true; # enableTransience = false;
    settings = {
      add_newline = true;
      character = {
        success_symbol = "[λ ➜](bold green)";
        error_symbol = "[❯](bold red)";
      };
    };
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
    options = [
      # "--no-aliases"
    ];
  };

  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal.family = "MesloLGS Nerd Font Mono";
        size = 12;
      };
      window = {
        dimensions = {
          lines = 25;
          columns = 80;
        };
        padding = {
          x = 10;
          y = 10;
        };
        background_opacity = 0.5;
        # startup_mode = "windowed";
      };
    };
  };
  home.file.".inputrc".source = ./dotfiles/inputrc;

}
