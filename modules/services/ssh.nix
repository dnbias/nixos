{ options, config, lib, ... }:

with lib;
with lib.my;
let cfg = config.modules.services.ssh;
in {
  options.modules.services.ssh = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    services.openssh = {
      enable = true;
      challengeResponseAuthentication = false;
      passwordAuthentication = false;
    };

    user.openssh.authorizedKeys.keys =
      if config.user.name == "dnbias"
      then [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPaCRjwLcOdiIKMgDyeAMkSXNGTlTHswyLuHGjg0j3tC daniel.biasiotto@edu.unito.it"]
      else [];
  };
}
