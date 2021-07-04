{ config, options, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.dev.cs;
in {
  options.modules.dev.cs = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    user.packages = with pkgs; [
      omnisharp-roslyn
      mono
    ];
  };
}
