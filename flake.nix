{
  description = "Tanish Bhandari's flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager }:
  let
    # Define the system configuration
    configuration = { pkgs, ... }: {
      environment.systemPackages = [
        pkgs.vim
        pkgs.direnv
        pkgs.age
        pkgs.sshs
        pkgs.atac
        pkgs.termshark
        pkgs.portal
        pkgs.glow
        pkgs.ipfetch
        pkgs.onefetch
        pkgs.portal
        pkgs.sops
        pkgs.home-manager
        pkgs.neofetch
      ];

      services.nix-daemon.enable = true;
      nix.settings.experimental-features = "nix-command flakes";
      programs.zsh.enable = true;
      system.configurationRevision = self.rev or self.dirtyRev or null;
      system.stateVersion = 4;
      nixpkgs.hostPlatform = "aarch64-darwin";
      security.pam.enableSudoTouchIdAuth = true;

      users.users.tanish.home = "/Users/tanish";
      home-manager.backupFileExtension = "backup";
      nix.configureBuildUsers = false;
      nix.useDaemon = true;

      system.defaults = {
        dock.autohide = true;
        dock.mru-spaces = false;
        finder.AppleShowAllExtensions = true;
        finder.FXPreferredViewStyle = "clmv";
        loginwindow.LoginwindowText = "WELCOME TANISH !";
        screencapture.location = "~/ss";
        screensaver.askForPasswordDelay = 10;
      };

      homebrew.enable = true;
      homebrew.casks = [
        "google-chrome"
        "obsidian"
        "telegram"
        "whatsapp"
        "firefox"
        "brave-browser"
        "discord"
        "visual-studio-code"
        "intellij-idea"
        "kitty"
        "wezterm"
        "jdownloader"
        "microsoft-office"
        "google-drive"
        "aldente"
        "rectangle"
        "chatgpt"
        "tailscale"
        "iina"
        "the-unarchiver"
        "balenaetcher"
        "stremio"
        "plex"
        "jellyfin-media-player"
        "font-hack-nerd-font"
        "font-sf-pro"
        "sf-symbols"
        "cakebrew"
        "spacedrive"
        "font-jetbrains-mono"
        "aerospace"
        "zed"
      ];
      homebrew.taps = [
        "FelixKratz/formulae"
        "nikitabobko/tap"
      ];
      homebrew.brews = [
        "aria2"
        "ripgrep"
        "stow"
        "bat"
        "eza"
        "starship"
        "fastfetch"
        "nvim"
        "ffmpeg"
        "fzf"
        "tmux"
        "yt-dlp"
        "youtube-dl"
        "rclone"
        "ranger"
        "yazi"
        "lazygit"
        "git"
        "fnm"
        "zoxide"
        "p7zip"
        "cups"
        "fd"
        "tree"
        "thefuck"
        "node"
        "zsh-autosuggestions"
        "zsh-syntax-highlighting"
        "bash"
        "sketchybar"
        "jq"
        "htop"
        "ansible"
      ];
    };
  in
  {
    darwinConfigurations."tanishs-MacBook-Air" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        configuration
        home-manager.darwinModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.tanish = import ./home.nix;  #this is symlinked to my config
        }
      ];
    };
    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."tanishs-MacBook-Air".pkgs;
  };
}


