{ pkgs, ... }: {
  programs.fish.enable = true;

  users = {
    defaultUserShell = pkgs.fish;

    users.matvii = {
      isNormalUser = true;
      description = "Matvii";
      extraGroups = [ "networkmanager" "wheel" "input" "libvirtd" ];
      packages = with pkgs; [];
    };
  };
}
