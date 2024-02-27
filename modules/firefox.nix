{ pkgs, inputs, ... }:
let
  oneFox = 
    pkgs.fetchFromGitHub {
      owner = "Perseus333";
      repo = "One-Fox";
      rev = "e9a1df53fdd80b4379a5ff89af256050daf3fe5b";
      sha256 = "sha256-up/LDgNGZEOyqZ9kitHjx7V+uD/32mqLeV2PfKvkU3Y=";
    };
in {


  programs.firefox = {
    enable = true;
    policies = {
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableTelemetry = true;
        DisableFirefoxAccounts = true;
        PromptForDownloadLocation = true;
        EnableTrackingProtection = {
          Value= true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
        DisableFirefoxScreenshots = true;
        OverrideFirstRunPage = "";
        OverridePostUpdatePage = "";
        DontCheckDefaultBrowser = true;
        DisplayBookmarksToolbar = "never"; # alternatives: "always" or "newtab"
        DisplayMenuBar = "default-off"; # alternatives: "always", "never" or "default-on"
    };
    profiles.default = {
      name = "Yuno";
      search.default = "Google";
      search.force = true;
      search.privateDefault = "DuckDuckGo";
      userChrome = builtins.concatStringsSep "\n"
        (builtins.map builtins.readFile [ "${oneFox}/chrome/userChrome.css" ]);
      settings = {

        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "layers.acceleration.force-enabled" = true;
        "gfx.webrender.all" = true;
        "svg.context-properties.content.enabled" = true;
        "browser.search.suggest.enable" = false;
        "browser.search.suggest.enable.private" = false;
        "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts" = false;
      };

      extensions = with pkgs.nur.repos.rycee.firefox-addons;
        [ ublock-origin
          tabliss
          darkreader
          return-youtube-dislikes
          sponsorblock
          enhancer-for-youtube
        ];
    };
  };
}

