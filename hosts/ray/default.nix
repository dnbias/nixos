{ pkgs, config, lib, ... }:
{
  imports = [
    ../home.nix
    ./hardware-configuration.nix
  ];

  
  ## Modules
  modules = {
    desktop = {
      bspwm.enable = true;
      apps = {
        discord.enable = true;
        rofi.enable = true;
        # godot.enable = true;
        signal.enable = true;
        # telegram.enable = true;
        # pgadmin.enable = true;
        dbeaver.enable = true;
      };
      browsers = {
        default = "firefox";
	      firefox.enable = true;
      };
      gaming = {
        # steam.enable = true;
        # emulators.enable = true;
        # emulators.psx.enable = true;
      };
      media = {
        daw.enable = true;
        documents.enable = true;
        graphics.enable = false;
        mpv.enable = true;
        mpd.enable = true;
        spotify.enable = true;
        ncmpcpp.enable = true;
        zathura.enable = true;
      };
      term = {
        default = "xst";
        st.enable = true;
      };
    };
    editors = {
      default = "nvim";
      emacs.enable = true;
      vim.enable = true;
    };
    shell = {
      adl.enable = true;
      bitwarden.enable = true;
      direnv.enable = true;
      git.enable    = true;
      gnupg.enable  = true;
      tmux.enable   = true;
      zsh.enable    = true;
    };
    services = {
      ssh.enable = true;
    };
    theme.active = "alucard";
  };
  
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  ## Local config
  programs.ssh.startAgent = true;
  services.openssh.startWhenNeeded = true;

  networking.networkmanager.enable = true;
  # The global useDHCP flag is deprecated, therefore explicitly set to false
  # here. Per-interface useDHCP will be mandatory in the future, so this
  # generated config replicates the default behaviour.
  networking.useDHCP = false;
}
