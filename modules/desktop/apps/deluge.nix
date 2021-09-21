{ options, config, lib, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.apps.deluge;
in {
  options.modules.desktop.apps.deluge = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
     user.packages = with pkgs; [
        deluge
    ];
  };
}
