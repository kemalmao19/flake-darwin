{ pkgs, ... }: {
  # here go the darwin preferences and config items
  programs.fish.enable = true;
  programs.zsh.enable = true;
  environment = {
    shells = with pkgs; [ bash zsh fish ];
    loginShell = pkgs.fish;
    systemPackages = [ pkgs.coreutils ];
    systemPath = [ "/opt/homebrew/bin" ];
    pathsToLink = [ "/Applications" ];
  };
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  system.activationScripts.postUserActivation.text = ''
    # Following line should allow us to avoid a logout/login cycle
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';
  # system.keyboard.enableKeyMapping = true;
  # system.keyboard.remapCapsLockToEscape = true;
  fonts.fontDir.enable = true; # DANGER
  fonts.fonts = [ (pkgs.nerdfonts.override { fonts = [ "Meslo" ]; }) ];
  services.nix-daemon.enable = true;
  system.defaults = {
    finder.AppleShowAllExtensions = true;
    finder._FXShowPosixPathInTitle = true;
    dock = {
      autohide = true;
      autohide-delay = 0.0;
      autohide-time-modifier = 0.2;
      expose-animation-duration = 0.2;
      tilesize = 24;
      launchanim = false;
      static-only = false;
      showhidden = true;
      show-recents = false;
      show-process-indicators = true;
      orientation = "bottom";
      mru-spaces = false;
      # mouse in top right corner will start screensaver
      wvous-tr-corner = 5;
    };
    NSGlobalDomain.AppleShowAllExtensions = true;
    NSGlobalDomain.InitialKeyRepeat = 14;
    NSGlobalDomain.KeyRepeat = 1;
  };

  # User Custom Preferences
  system.defaults.CustomUserPreferences = {
    NSGlobalDomain = {
      # Add a context menu item for showing the Web Inspector in web views
      WebKitDeveloperExtras = true;
    };
    "com.apple.finder" = {
      ShowExternalHardDrivesOnDesktop = false;
      ShowHardDrivesOnDesktop = false;
      ShowMountedServersOnDesktop = false;
      ShowRemovableMediaOnDesktop = true;
      _FXSortFoldersFirst = true;
      # When performing a search, search the current folder by default
      FXDefaultSearchScope = "SCcf";
    };
    "com.apple.desktopservices" = {
      # Avoid creating .DS_Store files on network or USB volumes
      DSDontWriteNetworkStores = true;
      DSDontWriteUSBStores = true;
    };
    "com.apple.screensaver" = {
      # Require password immediately after sleep or screen saver begins
      askForPassword = 1;
      askForPasswordDelay = 0;
    };
    "com.apple.screencapture" = {
      location = "~/Desktop";
      type = "png";
    };
    "com.apple.Safari" = {
      # Privacy: don’t send search queries to Apple
      UniversalSearchEnabled = false;
      SuppressSearchSuggestions = true;
      # Press Tab to highlight each item on a web page
      WebKitTabToLinksPreferenceKey = true;
      ShowFullURLInSmartSearchField = true;
      # Prevent Safari from opening ‘safe’ files automatically after downloading
      AutoOpenSafeDownloads = false;
      ShowFavoritesBar = false;
      IncludeInternalDebugMenu = true;
      IncludeDevelopMenu = true;
      WebKitDeveloperExtrasEnabledPreferenceKey = true;
      WebContinuousSpellCheckingEnabled = true;
      WebAutomaticSpellingCorrectionEnabled = false;
      AutoFillFromAddressBook = false;
      AutoFillCreditCardData = false;
      AutoFillMiscellaneousForms = false;
      WarnAboutFraudulentWebsites = true;
      WebKitJavaEnabled = false;
      WebKitJavaScriptCanOpenWindowsAutomatically = false;
      "com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks" = true;
      "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" =
        true;
      "com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled" =
        false;
      "com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabled" = false;
      "com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabledForLocalFiles" =
        false;
      "com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaScriptCanOpenWindowsAutomatically" =
        false;
    };
    "com.apple.mail" = {
      # Disable inline attachments (just show the icons)
      DisableInlineAttachmentViewing = true;
    };
    "com.apple.AdLib" = { allowApplePersonalizedAdvertising = false; };
    "com.apple.print.PrintingPrefs" = {
      # Automatically quit printer app once the print jobs complete
      "Quit When Finished" = true;
    };
    "com.apple.SoftwareUpdate" = {
      AutomaticCheckEnabled = false;
      # Check for software updates daily, not just once per week
      ScheduleFrequency = 0;
      # Download newly available updates in background
      AutomaticDownload = 0;
      # Install System data files & security updates
      CriticalUpdateInstall = 0;
    };
    "com.apple.TimeMachine".DoNotOfferNewDisksForBackup = true;
    # Prevent Photos from opening automatically when devices are plugged in
    "com.apple.ImageCapture".disableHotPlug = true;
    # Turn on app auto-update
    "com.apple.commerce".AutoUpdate = false;
  };

  # YABAI Window Manager
  # services.yabai = {
  #   enable = true;
  #   config = {
  #         focus_follows_mouse = "autoraise";
  #         # mouse_follows_focus = "off";
  #         window_placement    = "second_child";
  #         window_opacity      = "off";
  #         top_padding         = 10;
  #         bottom_padding      = 10;
  #         left_padding        = 10;
  #         right_padding       = 10;
  #         window_gap          = 10;
  #       };
  #   extraConfig = ''
  #     yabai -m rule --add app='System Preferences' manage=off
  #   '';
  #   # enableScriptingAddition = true;
  # };

  # KWM WIndow Manager
  services.kwm = {
    enable = true;
    
  };

  # backwards compat; don't change
  system.stateVersion = 4;
  homebrew = {
    enable = true;
    caskArgs.no_quarantine = true;
    global.brewfile = true;
    masApps = { };
    casks = [ "amethyst" ];
    taps = [ ];
    brews = [ ];
  };
}
