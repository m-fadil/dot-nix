{ pkgs, ... }:

{
  # Power management untuk laptop
  services.upower.enable = true;
  
  # TLP untuk battery optimization
  services.tlp = {
    enable = false;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      
      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 60;
      
      START_CHARGE_THRESH_BAT0 = 40;
      STOP_CHARGE_THRESH_BAT0 = 80;
    };
  };

  # Gunakan power-profiles-daemon sebagai stack power utama.
  services.power-profiles-daemon.enable = true;

  # Optional integrations useful for DMS features
  services.fprintd.enable = true;

  # Backlight control via brightnessctl package
  # Hardware Sensors
  hardware.sensor.iio.enable = true;
  
  # Touchpad support
  services.libinput = {
    enable = true;
    touchpad = {
      tapping = true;
      naturalScrolling = true;
      disableWhileTyping = true;
    };
  };

  # Laptop specific packages
  environment.systemPackages = with pkgs; [
    brightnessctl
    powertop
    acpi
    poweralertd
    lm_sensors
    cups-pk-helper
  ];
}
