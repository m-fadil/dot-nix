{ lib, osConfig, inputs, pkgs, pkgsUnstable, ... }:

{
  imports = [
    inputs.dms.homeModules.dank-material-shell
    inputs.dms-plugin-registry.homeModules.default
  ];

  config = lib.mkIf (osConfig.my.shell == "dms") {
    programs.quickshell.package = lib.mkForce pkgsUnstable.quickshell;

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

      dgop.package = inputs.dgop.packages.${pkgs.stdenv.hostPlatform.system}.default;

      plugins = {
        dankBatteryAlerts.enable = true;
      };
    };
  };
}
