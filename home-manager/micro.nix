{ config, pkgs, ... }:
{
	programs.micro = {
		enable = true;
		  settings = {
		    "tabstospaces" = true;
		    "softwrap" = true;
		    "savecursor" = true;
		    "saveundo" = true;
		    "savestate" = true;
        };
    };
}
