{stdenvNoCC, fetchFromGitHub, theme}:

stdenvNoCC.mkDerivation {
    name = "catppuccin-kitty-theme";
    dontConfigure = true;

    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "kitty";
      rev = "d7d61716a83cd135344cbb353af9d197c5d7cec1";
      sha256 = "sha256-mRFa+40fuJCUrR1o4zMi7AlgjRtFmii4fNsQyD8hIjM=";
    };
    installPhase = 
    ''
      DIR=`pwd`
      mkdir $out
      cp ./themes/${theme}.conf $out
    '';
  }
