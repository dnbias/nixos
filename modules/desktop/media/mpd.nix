{ config, options, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.media.mpd;
    configDir = config.dotfiles.configDir;
in {
  options.modules.desktop.media.mpd = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    user.packages = with pkgs; [
      mpd
    ];
    services = {
        mpd.enable = true;
    };
    env.MPD_HOME = "$XDG_CONFIG_HOME/mpd";
    home.configFile = {
      "mpd".source   = "${configDir}/mpd";
    };
  };
}
