{pkgs, ...}:
{
  home.packages = with pkgs;
    [ nodejs_21
      nodePackages.pyright
    ];
}
