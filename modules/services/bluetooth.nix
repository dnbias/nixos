{ options, config, lib, ... }:

with lib;
with lib.my;
let cfg = config.modules.services.bluetooth;
in {
  options.modules.services.bluetooth = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    services.bluetooth = {
      enable = true;
    };
  };
}
