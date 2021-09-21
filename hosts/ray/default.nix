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
        dropbox.enable = true;
        rofi.enable = true;
        ranger.enable = true;
        # godot.enable = true;
        signal.enable = true;
        telegram.enable = true;
        # pgadmin.enable = true;
        dbeaver.enable = true;
        unity.enable = true;
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
        # daw.enable = true;
        documents.enable = true;
        documents.ebook.enable = true;
        documents.pdf.enable = true;
        graphics.enable = true;
        graphics.tools.enable = true;
        graphics.photo.enable = true;
        mpv.enable = true;
        spotify.enable = true;
        ncmpcpp.enable = true;
        mpd.enable = true;
      };
      term = {
        default = "xst";
        st.enable = true;
      };
    };
    editors = {
      default = "emacs";
      emacs.enable = true;
      vscode.enable = true;
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
      bluetooth.enable = true;
      deluge.enable = true;
    };
    dev = {
      cc.enable = true;
      cs.enable = true;
      java.enable = true;
      python.enable = true;
      web.enable = true;
    };
    theme.active = "citylights";
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
