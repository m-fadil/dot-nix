{ pkgs, ... }:

{
	home.packages = with pkgs; [
		xpra
	  # wayvnc
	];

	# security.polkit.enable = true;
}
