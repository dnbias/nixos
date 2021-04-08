{ config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.apps.dbeaver;
  
in {
  options.modules.desktop.apps.dbeaver = {
    enable = mkBoolOpt false;
  };
  config = mkIf cfg.enable {
    user.packages = with pkgs; [
      dbeaver
      unixODBCDrivers.psql
      postgis
      postgresql_jdbc
    ];
  };
}
