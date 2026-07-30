{ inputs, pkgs, pkgsUnstable, ... }:

{
  imports = [
    # Dev packages from categories
    ../../dev/git
    ../../dev/gh
    ../../shell/delta
    ../../dev/lazygit
    ../../dev/nodejs
    ../../dev/python3
    ../../dev/android-tools
    ../../dev/scrcpy
    ../../dev/sourcegit
    ../../dev/bruno
    ../../dev/dbeaver
    
    # Editors from categories
    ../../editors/helix
    ../../editors/neovim
    ../../editors/vscode

    # Virt tools
  ];
}
