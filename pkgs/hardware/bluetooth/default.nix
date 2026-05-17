{ pkgs, ... }:

{
  # Enable bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        Experimental = true;
      };
    };
  };

  # Bluetooth manager GUI
  # services.blueman.enable = true;

  # Bluetooth packages
  environment.systemPackages = with pkgs; [
    bluez
    bluez-tools
  ];
}
