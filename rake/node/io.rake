desc "My main computer"
task :io do
  [ "pkg:update",
    "pkg:osx",
    "pkg:zsh",
    "pkg:vim",
    "pkg:emacs",
    "pkg:rbenv",
    "pkg:pyenv",
    "pkg:love"
  ].each { |task| Rake::Task[task].invoke }

  # Install my the mac-apps I commonly use
  if is_mac?
    [ "transmit",
      "transmission",
      "vlc",
      "flux",
      "skype",
      "adium",
      "codekit",
      "mindnode-pro",
      "sequel-pro",
      "scrivener",
      "omnigraffle",

      # Quicklook plugins
      "qlcolorcode",
      "qlstephen",
      "qlmarkdown",
      "quicklook-json",
      "qlprettypatch",
      "quicklook-csv",
      "betterzipql",
      "webp-quicklook",
      "suspicious-package"
    ].each { |app| Package.cask_install app }
  end
end