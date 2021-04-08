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
    home.configFile = {
      "mpd/mpd.conf".source   = "${configDir}/mpd/mpd.conf";
      "mpd/pid".source   = "${configDir}/mpd/pid";
    };
  };
}
