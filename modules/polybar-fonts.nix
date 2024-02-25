{stdenvNoCC, fetchFromGitHub, ...}:

  stdenvNoCC.mkDerivation {
          name = "polybar-fonts";
          dontConfigue = true;
          src = fetchFromGitHub {
            owner = "adi1090x";
            repo = "polybar-themes";
            rev = "2a0e6ba8dd946de6d4e6a29a2d8e945a5e80c216";
            sha256 = "sha256-n5UcGHU/DQYezIma9w3zAQ2QZ7q6TmnbWYghT0EIETU=";
          };
          installPhase = ''
		        STYLE='simple'
            DIR=`pwd`
            FDIR="$out/share/fonts"

            mkdir -p $FDIR
            cp -rf $DIR/fonts/* "$FDIR"

          '';
        }
