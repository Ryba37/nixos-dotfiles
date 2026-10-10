{ pkgs, ... }:

let
  font = {
    name = "JetBrainsMono Nerd Font";
    size = 11;
  };
in
{
  home.packages = [ pkgs.nerd-fonts.jetbrains-mono ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [ font.name ];
      sansSerif = [ font.name ];
      serif = [ font.name ];
    };
  };

  gtk = {
    enable = true;

    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };

    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };

    font = {
      inherit (font) name size;
    };

    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
  };

  dconf.settings."org/gnome/desktop/interface" = {
    color-scheme = "prefer-dark";
    font-name = "${font.name} ${toString font.size}";
    monospace-font-name = "${font.name} ${toString font.size}";
    document-font-name = "${font.name} ${toString font.size}";
  };
}
