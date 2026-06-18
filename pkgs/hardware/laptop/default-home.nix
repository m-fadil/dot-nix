{ pkgs, ... }:

{
  # Laptop specific user packages
  home.packages = with pkgs; [];

  services.swayidle = {
    enable = true;
    events = {
      before-sleep = "loginctl lock-session";
      lock = "loginctl lock-session";
      unlock = "true";
    };
    timeouts = [
      {
        timeout = 300;
        command = "loginctl lock-session";
        resumeCommand = "true";
      }
      { timeout = 600; command = "systemctl suspend"; }
    ];
  };
}
