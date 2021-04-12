{ config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.dev.web;
in {
  options.modules.dev.web = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    user.packages = with pkgs; [
      go
      hugo
    ];
  };
}
