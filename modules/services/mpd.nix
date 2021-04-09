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
    services.mpd = {
      user = "dnbias";
      enable = true;
    };
    env.MPD_HOME = "$XDG_CONFIG_HOME/mpd";
    home.configFile = {
      "mpd".source   = "${configDir}/mpd";
    };
  };
}
