# Emacs is my main driver. I'm the author of Doom Emacs
# https://github.com/hlissner/doom-emacs. This module sets it up to meet my
# particular Doomy needs.

{ config, lib, pkgs, inputs, ... }:

with lib;
with lib.my;
let cfg = config.modules.editors.emacs;
    configDir = config.dotfiles.configDir;
    emacsPackages = let epkgs = pkgs.emacsPackagesFor cfg.package;
                    in epkgs.overrideScope' cfg.overrides;
    emacsWithPackages = emacsPackages.emacsWithPackages;
in {
  options.modules.editors.emacs = {
    enable = mkBoolOpt false;
    doom = {
      enable  = mkBoolOpt true;
      fromSSH = mkBoolOpt false;
    };
  };

  config = mkIf cfg.enable {
    nixpkgs.overlays = [ inputs.emacs-overlay.overlay ];

    user.packages = with pkgs; [
      ## Emacs itself
      binutils       # native-comp needs 'as', provided by this
      emacsPgtkGcc   # 28 + pgtk + native-comp

      ## Doom dependencies
      git
      (ripgrep.override {withPCRE2 = true;})
      gnutls              # for TLS connectivity

      ## Optional dependencies
      fd                  # faster projectile indexing
      imagemagick         # for image-dired
      (mkIf (config.programs.gnupg.agent.enable)
        pinentry_emacs)   # in-emacs gnupg prompts
      zstd                # for undo-fu-session/undo-tree compression

      ## Module dependencies
      # :checkers spell
      (aspellWithDicts (ds: with ds; [
        en en-computers en-science
      ]))
      # :checkers grammar
      languagetool
      # :tools editorconfig
      editorconfig-core-c # per-project style config
      # :tools lookup & :lang org +roam
      sqlite
      # :lang cc
      ccls
      # :lang javascript
      nodePackages.javascript-typescript-langserver
      # :lang latex & :lang org (latex previews)
      texlive.combined.scheme-medium
      # :lang rust
      rustfmt
      unstable.rust-analyzer
      # :lang java
      jdk   
      maven
    ];

    env.PATH = [ "$XDG_CONFIG_HOME/emacs/bin" ];

    modules.shell.zsh.rcFiles = [ "${configDir}/emacs/aliases.zsh" ];

    fonts.fonts = [
      pkgs.emacs-all-the-icons-fonts
      pkgs.iosevka
    ];

    # meta.maintainers = [ maintainers.rycee ];

    # options = {
    #   programs.emacs = {
    #     enable = mkEnableOption "Emacs";
    #     package = mkOption {
    #       type = types.package;
    #       default = pkgs.emacs;
    #       defaultText = literalExample "pkgs.emacs";
    #       example = literalExample "pkgs.emacs25-nox";
    #       description = "The Emacs package to use.";
    #    };
    #     extraPackages = mkOption {
    #       default = self: [ ];
    #       type = hm.types.selectorFunction;
    #       defaultText = "epkgs: []";
    #       example = literalExample "epkgs: [ epkgs.emms epkgs.magit ]";
    #      description = ''
    #                   Extra packages available to Emacs. To get a list of
    #                   available packages run:
    #                   <command>nix-env -f '&lt;nixpkgs&gt;' -qaP -A emacsPackages</command>.
    #                  '';
    #     };

    #    overrides = mkOption {
    #       default = self: super: { };
    #       type = hm.types.overlayFunction;
    #       defaultText = "self: super: {}";
    #       example = literalExample ''
    #               self: super: rec {
    #               haskell-mode = self.melpaPackages.haskell-mode;
    #               # ...
    #               };
    #               '';
    #       description = ''
    #                   Allows overriding packages within the Emacs package set.
    #                   '';
    #     };

    #     finalPackage = mkOption {
    #       type = types.package;
    #       visible = false;
    #       readOnly = true;
    #       description = ''
    #                   The Emacs package including any overrides and extra packages.
    #                   '';
    #     };
    #   };
    # };

    # config = mkIf cfg.enable {
    #   home.packages = [ cfg.finalPackage ];
    #   programs.emacs.finalPackage = emacsWithPackages cfg.extraPackages;
    # };
    # init.doomEmacs = mkIf cfg.doom.enable ''
    #   if [ -d $HOME/.config/emacs ]; then
    #      ${optionalString cfg.doom.fromSSH ''
    #         git clone git@github.com:hlissner/doom-emacs.git $HOME/.config/emacs
    #         git clone git@github.com:hlissner/doom-emacs-private.git $HOME/.config/doom
    #      ''}
    #      ${optionalString (cfg.doom.fromSSH == false) ''
    #         git clone https://github.com/hlissner/doom-emacs $HOME/.config/emacs
    #         git clone https://github.com/hlissner/doom-emacs-private $HOME/.config/doom
    #      ''}
    #   fi
    # '';
  };

  
  
}
