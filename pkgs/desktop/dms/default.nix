{ lib, osConfig, inputs, pkgs, ... }:

let
  hasDmsInputs = inputs ? dms && inputs ? dms-plugin-registry;
in
if !hasDmsInputs then
  {}
else
  {
    imports = [
      inputs.dms.homeModules.dank-material-shell
      inputs.dms-plugin-registry.homeModules.default
    ];

    config = lib.mkIf (osConfig.my.desktop == "hyprland") {
      programs.dank-material-shell = {
        enable = true;
        settings = import ./settings.nix;
        managePluginSettings = true;

        systemd = {
          enable = true;
          restartIfChanged = true;
        };

        enableSystemMonitoring = true;
        enableVPN = true;
        enableDynamicTheming = true;
        enableAudioWavelength = true;
        enableCalendarEvents = true;
        enableClipboardPaste = true;

        plugins = {
          dankBatteryAlerts.enable = true;
        };
      } // lib.optionalAttrs (inputs ? dgop) {
        dgop.package = inputs.dgop.packages.${pkgs.stdenv.hostPlatform.system}.default;
      };
    };
  }
