{ config, lib, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix

      ./packages.nix
      ./modules/bundle.nix
    ];

  networking.hostName = "nixos"; # Define your hostname.

  i18n.defaultLocale = "en_US.UTF-8";

  nix.settings.experimental-features = [ "nix-command" "flakes" ]; 

  time.timeZone = "Europe/Warsaw";

  hardware.graphics.enable32Bit = true;

  system.stateVersion = "26.05"; # Did you read the comment?
}

