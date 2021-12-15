{ config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.apps.chatterino;
in {
  options.modules.desktop.apps.chatterino = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
     user.packages = with pkgs; [
        chatterino2
    ];
  };
}
