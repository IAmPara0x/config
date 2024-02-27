{pkgs, ...}: {

  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    # archives
    zip
    unzip
    unrar

    # misc
    libnotify
    fontconfig

    # utils
    dijo
    du-dust
    duf
    fd
    feh
    file
    jaq
    ripgrep
    killall
    curl
    wget
    tree
    btop

    yt-dlp
    termusic
  ];

  programs = {
    eza.enable = true;
    ssh.enable = true;
    dircolors = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
