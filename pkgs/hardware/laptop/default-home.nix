{ pkgs, ... }:

{
  # Laptop specific user packages
  home.packages = with pkgs; [];

  services.swayidle = {
    enable = true;
    events = [
      {
        event = "before-sleep";
        command = "loginctl lock-session";
      }
      {
        event = "lock";
        command = "loginctl lock-session";
      }
      {
        event = "unlock";
        command = "true";
      }
    ];
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
