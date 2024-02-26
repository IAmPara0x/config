{ pkgs, config, ... }:
let
  oneFox = 
    pkgs.fetchFromGitHub {
      owner = "Perseus333";
      repo = "One-Fox";
      rev = "e9a1df53fdd80b4379a5ff89af256050daf3fe5b";
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
    };
    profiles = {
      isDefault = true;
      name = "yuno";
      search.default = "Google";
      search.force = true;
      search.privateDefault = "DuckDuckGo";
      userChrome = builtins.concatStringsSep "\n"
        (builtins.map builtins.readFile [ "${oneFox}/userChrome.css" ]);
      userContent = ''
          @-moz-document url-prefix("about:newtab"),
          url-prefix("about:home") {
              /*Hides the Releases and Support Links*/
              #floorp {
                  display: none;
              }
              /*Hides the cog button to customize the new tab*/
              [data-l10n-id="newtab-personalize-icon-label"] {
                  display: none !important;
              }
              /*Removes the Floorp Logo*/
              .logo-and-wordmark {
                  display: none !important;
              }
              main {
                  display: none;
              }
              #background {
                  background-image: url(${config.home.homeDirectory}/.config/Wallpapers/f16fedc86686146624897737cf4338d8.jpg) !important;
                  background-size: cover;
                  background-position: center;
                  background-repeat: no-repeat;
              }
              .selected_image {
                  background-color: transparent !important;
              }
          }

          /*Autofilled forms have a light blue tint*/

          input:autofill {
              background: #ffffff00 !important;
          }
      '';
    };
  };
}

