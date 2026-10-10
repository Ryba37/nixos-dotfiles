{ lib, pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    extraPackages = with pkgs; [
      ripgrep
      fd
      gcc
      lua-language-server
      nixd
    ];
  };

  xdg.configFile."nvim".source = lib.cleanSourceWith {
    src = ./.;
    filter = path: _: baseNameOf path != "default.nix";
  };
}
