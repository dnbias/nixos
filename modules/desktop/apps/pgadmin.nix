{ config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.apps.pgadmin;



    
in {
  nixpkgs.config = {
    permittedInsecurePackages = [
      "openssl-1.0.2u"
    ];
  };
  options.modules.desktop.apps.pgadmin = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    user.packages = with pkgs; [
      pgadmin
    ];
  };
}
