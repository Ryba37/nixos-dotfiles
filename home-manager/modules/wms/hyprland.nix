{
  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";
    xwayland.enable = true;
    extraConfig = builtins.readFile ./hyprland.lua;
  };
}
