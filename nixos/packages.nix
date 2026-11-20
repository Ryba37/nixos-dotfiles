{ pkgs, ... }: {
  nixpkgs.config = {
    allowUnfree = true;
  };

  programs.steam.enable = true;

  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "matvii" ];

  environment.systemPackages = with pkgs; [
    awww
    mako
    grimblast

    alacritty
    kitty
    fastfetch
    helium
    fuzzel
    git
    wl-clipboard
    neovim

    home-manager
    vesktop

    librepods

    openjdk25
    python3
  ];

  fonts.packages = with pkgs; [
    jetbrains-mono
    noto-fonts
    noto-fonts-color-emoji
    twemoji-color-font
    font-awesome
  ];
}
