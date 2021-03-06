# modules/desktop/media/docs.nix

{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.media.documents;
in {
  options.modules.desktop.media.documents = {
    enable = mkBoolOpt false;
    pdf.enable = mkBoolOpt false;
    ebook.enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    user.packages = with pkgs; [
      (mkIf cfg.ebook.enable calibre)
      (mkIf cfg.pdf.enable   evince)
      (mkIf cfg.pdf.enable   xournalpp)
      zathura
      texlive.combined.scheme-full
    ];

    # TODO calibre/evince/zathura dotfiles
    #home.configFile = {
    #  "zathura".source = "${config.dotfiles.configDir}/zathura/zathurarc";
    #};
  };
}
