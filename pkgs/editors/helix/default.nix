{ pkgs, ... }:

{
  programs.helix = {
    enable = true;
    settings = {
      theme = "onedark";

      editor.true-color = true;

      editor.cursor-shape.insert = "bar";
      editor.cursor-shape.normal = "block";
      editor.cursor-shape.select = "underline";

      editor.file-picker.git-ignore = false;
      editor.file-picker.git-global = false;

      keys.insert.tab = "insert_tab";
    };
  };
}
