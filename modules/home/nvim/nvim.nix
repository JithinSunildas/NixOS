{ config, pkgs, ... }:

{
	xdg.configFile."nvim/init.lua".source = ./nvim/init.lua;
}
