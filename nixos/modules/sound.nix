{
  services.pulseaudio.enable = false;

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;

    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    wireplumber.extraConfig."51-bluez-avrcp" = {
      "monitor.bluez.properties"."bluez5.dummy-avrcp-player" = true;
    };

    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };
}
