{pkgs, lib, ...}:

{
  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [ vim-surround vim-substrata auto-pairs ];
    settings = { ignorecase = true; };
    extraConfig = ''
      set mouse=a
      set tabstop=2
      set shiftwidth=2
      set autoread
      set clipboard=unnamedplus

      set hlsearch
      set incsearch
      set ignorecase
      set smartcase
      set gdefault

      set copyindent
      set smarttab
      set autoindent
      set smartindent

      syntax enable
      colorscheme substrata

      let mapleader =" "
      inoremap jk <Esc>
      nnoremap <leader>fs :update<cr>
      nnoremap Y y$
    '';
  };
}
