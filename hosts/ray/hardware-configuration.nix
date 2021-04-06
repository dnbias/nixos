{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ "${modulesPath}/installer/scan/not-detected.nix" ];

  boot = {
    initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
    initrd.kernelModules = [];
    extraModulePackages = [];
    kernelModules = [];
    kernelParams = [];
  };

  # Modules
  modules.hardware = {
    audio.enable = true;
    fs = {
      enable = true;
      ssd.enable = true;
    };
    sensors.enable = true;
  };

  # CPU
  nix.maxJobs = lib.mkDefault 16;
  powerManagement.cpuFreqGovernor = "performance";
  hardware.cpu.amd.updateMicrocode = true;

  # Storage
  fileSystems = {
    "/" = {
      device = "/dev/sdb3";
      fsType = "ext4";
      options = [ "noatime" ];
    };
    "/boot" = {
      device = "/dev/sdb1";
      fsType = "vfat";
    };
    "/usr/drive" = {
      device = "/dev/sda1";
      fsType = "ntfs";
      options = [
        "nofail" "noauto" "noatime" "x-systemd.automount" "x-systemd.idle-timeout=5min"
        "nodev" "nosuid" "noexec"
      ];
    };
  };
  swapDevices = [{ device = "/dev/sdb2"; }];
}
