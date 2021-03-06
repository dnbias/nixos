{ config, lib, ... }:

with lib;
{ 
  networking.hosts =
    let hostConfig = {
          "192.168.1.10" = [ "ray" ];
        };
        hosts = flatten (attrValues hostConfig);
        hostName = config.networking.hostName;
    in mkIf (builtins.elem hostName hosts) hostConfig;

  ## Location config
  time.timeZone = mkDefault "Europe/Rome";
  i18n.defaultLocale = mkDefault "en_US.UTF-8";
  # For redshift, mainly
  location = (if config.time.timeZone == "Europe/Rome" then {
    latitude = 45.07;
    longitude = 7.69;
  } else {});

  # So the bitwarden CLI knows where to find my server.
  # modules.shell.bitwarden.config.server = "p.v0.io";


  ## Not using syncthing atm
  # services.syncthing.declarative = {
  #   # Purge folders not declaratively configured!
  #   overrideFolders = true;
  #   overrideDevices = true;
  #   devices = {
  #     kuro.id  = "4UJSUBN-V7LCISG-6ZE7SBN-YPXM5FQ-CE7CD2U-W4KZC7O-4HUZZSW-6DXAGQQ";
  #     shiro.id = "G4DUO25-AMQQIWS-SRZE5TJ-43CCQZJ-5ULEZBS-P2LMZZU-V5JA5CS-6X7RLQK";
  #     kiiro.id = "3A6G2NR-WQMASWG-7EFUX6G-GJB6WYX-HYGDA7N-EYZYANY-NDRKI3W-32RQ4QG";
  #   };
  #   folders =
  #     let mkShare = devices: type: paths: attrs: (rec {
  #           inherit devices type;
  #           path = if lib.isAttrs paths
  #                  then paths."${config.networking.hostName}"
  #                  else paths;
  #           watch = false;
  #           rescanInterval = 3600; # every hour
  #           enable = lib.elem config.networking.hostName devices;
  #         } // attrs);
  #     in {
  #       projects = mkShare [ "kuro" "shiro" ] "sendreceive" #         "${config.user.home}/projects"
  #         { watch = true;
  #           rescanInterval = 3600 * 4; }; # every 4 hours
  #       serverBackup = mkShare [ "ao" "kiiro" ] "sendonly" "/run/backups"
  #       mainBackup = mkShare [ "kuro" "kiiro" ] "sendreceive" #         "/usr/store"
  #         { versioning = {
  #             type = "staggered";
  #             params.maxAge = "356";
  #           }; };
  #     };
  # };
}
