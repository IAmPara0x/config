{ pkgs, lib, ... }: {

  programs.chromium = {
    enable = true;
    package = pkgs.ungoogled-chromium;
    extensions = let
      createChromiumExtensionFor = browserVersion:
        { id, sha256, version }: {
          inherit id;
          crxPath = builtins.fetchurl {
            url =
              "https://clients2.google.com/service/update2/crx?response=redirect&acceptformat=crx2,crx3&prodversion=${browserVersion}&x=id%3D${id}%26installsource%3Dondemand%26uc";
            name = "${id}.crx";
            inherit sha256;
          };
          inherit version;
        };
      createChromiumExtension = createChromiumExtensionFor
        (lib.versions.major pkgs.ungoogled-chromium.version);
    in [
      (createChromiumExtension {
        # ublock origin
        id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";
        sha256 = "sha256:07h94p8a02h23sqwbllhj47k3inlahnd4pbvqpim0wywa4yqzca3";
        version = "1.56.0";
      })
      (createChromiumExtension {
        # dark reader
        id = "eimadpbcbfnmbkopoojfekhnkhdbieeh";
        sha256 = "sha256:1yhc6wsqwgdy9k5shnyqhqckpw8h7b70dchj1092cisjavq2l8fw";
        version = "4.9.77";
      })
    ];
  };
}

