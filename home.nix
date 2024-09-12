{ config, pkgs, lib, ... }:

{
  home.username = "tanish";
  home.homeDirectory = lib.mkForce "/Users/tanish";  # Ensure this value is enforced
  home.stateVersion = "23.05"; # Adjust if necessary
  home.file.".config/starship.toml" = {
  source = ./dotfiles/.config/starship.toml;
  };
  home.file.".zshrc" = {
  source = ./dotfiles/.zshrc;
  };
  home.file.".tmux.conf" = {
  source = ./dotfiles/.tmux.conf;
  };
  home.file.".config/fastfetch" = {
  source = ./dotfiles/.config/fastfetch;
  recursive = true;
  };
  home.file.".config/aerospace" = {
  source = ./dotfiles/.config/aerospace;
  recursive = true;
  };
  home.file.".config/wezterm" = {
  source = ./dotfiles/.config/wezterm;
  recursive = true;
  };
  home.file.".config/sketchybar" = {
  source = ./dotfiles/.config/sketchybar;
  recursive = true;
  };
  home.file.".config/nvim" = {
  source = ./dotfiles/.config/nvim;
  recursive = true;
  };
  # Makes sense for user-specific applications that shouldn't be available system-wide
  home.packages = [
        pkgs.hello
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  

  home.sessionVariables = {
  };

  home.sessionPath = [
    "/run/current-system/sw/bin"
    "$HOME/.nix-profile/bin"
  ];
  programs.home-manager.enable = true;

}



