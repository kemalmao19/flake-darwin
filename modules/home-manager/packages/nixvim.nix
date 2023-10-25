{pkgs, nixvim, ...}: {

  imports = [nixvim.nixDarwinModules.nixvim]; 

  programs.nixvim = {
    # Enable gruvbox
    enable = true;

  };

}
