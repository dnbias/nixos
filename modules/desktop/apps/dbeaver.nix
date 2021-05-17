{ config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.apps.dbeaver;
  
in {
  options.modules.desktop.apps.dbeaver = {
    enable = mkBoolOpt false;
  };
  nixpkgs.config.permittedInsecurePackages = [
    "libgcrypt-1.5.6"
  ];
  config = mkIf cfg.enable {
    user.packages = with pkgs; [
      staruml
      dbeaver
      unixODBCDrivers.psql
      postgis
      postgresql_jdbc
    ];
  };
}
