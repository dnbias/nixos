{ config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.apps.dbeaver;
nixpkgs.config.permittedInsecurePackages = [
   "libgcrypt-1.5.6"
]; 
in {
  options.modules.desktop.apps.dbeaver = {
    enable = mkBoolOpt false;
  };
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
