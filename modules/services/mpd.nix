{ config, options, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.services.mpd;
    configDir = config.dotfiles.configDir;
in {
  options.modules.services.mpd = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    services.mpd = {
      user = "dnbias";
      dataDir = "${configDir}/mpd";
      musicDirectory = "${config.user.home}/Music";
      network.listenAddress = "127.0.0.1";
      extraConfig = "
          auto_update \"yes\"\n
          audio_output {
            type \"pulse\"\n
            name \"My Pulse Device\"\n
            server \"localhost\" }";
      enable = true;
    };
    home.configFile = {
      "mpd".source   = "${configDir}/mpd";
    };
  };
}
