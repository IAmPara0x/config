{ stdenvNoCC, fetchFromGitHub, theme }:

stdenvNoCC.mkDerivation {
  name = "catppuccin-zathura-theme";
  dontConfigure = true;

  src = fetchFromGitHub {
    owner = "catppuccin";
    repo = "zathura";
    rev = "1bda9d8274dd327b7931886ef0c5c1eb33903814";
  };
  installPhase = ''
    DIR=`pwd`
    mkdir $out
    cp ./themes/catppuccin-${theme}.conf $out
  '';
}
