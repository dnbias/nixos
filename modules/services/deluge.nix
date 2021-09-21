{ options, config, lib, ... }:

with lib;
with lib.my;
let cfg = config.modules.services.deluge;
in {
  options.modules.services.deluge = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
     user.packages = with pkgs; [
        deluge
    ];

  };
}
