{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        Experimental = true;
      };
    };
    input.General.ClassicBoundedOnly = false;
  };

  services.blueman.enable = true;
}
