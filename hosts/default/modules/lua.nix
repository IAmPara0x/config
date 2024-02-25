{pkgs, ...}:
{
  home.packages = with pkgs; [
      lua
      luajitPackages.luarocks
  ];
}

