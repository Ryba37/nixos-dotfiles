{ pkgs, ... }: {
  nixpkgs.config = {
    allowUnfree = true;
  };

  programs.steam.enable = true;

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
    proton-vpn-cli

    librepods
  ];

  fonts.packages = with pkgs; [
    jetbrains-mono
    noto-fonts
    noto-fonts-color-emoji
    twemoji-color-font
    font-awesome
  ];
}
