{ lib, osConfig, inputs, ... }:

{
  imports = [ inputs.noctalia.homeModules.default ];

  config = lib.mkIf (osConfig.my.shell == "noctalia") {
    programs.noctalia = {
      enable = true;

      # `package` sengaja tidak diset: inputs.noctalia.homeModules.default
      # sudah mengisinya lewat mkDefault dari packages.default flake-nya.
      # Modul upstream punya assertion package != null saat systemd.enable.
      systemd.enable = true;

      # Kosong = tidak ada ~/.config/noctalia/config.toml yang ditulis, jadi
      # Noctalia pakai default-nya dan settings menu runtime tetap bisa nulis.
      # Begitu diisi, file jadi read-only symlink ke store dan menu runtime
      # tidak lagi persisten. Format TOML, ref: https://docs.noctalia.dev/v5
      # settings = { theme = { mode = "dark"; }; };
    };
  };
}
