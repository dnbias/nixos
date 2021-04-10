{ config, options, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.services.mpd;
    configDir = config.dotfiles.configDir;
in {
  options.modules.desktop.media.mpd = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    user.packages = with pkgs; [
	    mpd
    ];

    home.configFile = {
      "mpd".source   = "${configDir}/mpd";
    };
  };
}
