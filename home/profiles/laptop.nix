{ pkgs, ... }:

{
  # Laptop specific user packages
  home.packages = with pkgs; [
    brightnessctl
    acpi
    
    # Battery monitoring
    # powerstat
  ];
}
