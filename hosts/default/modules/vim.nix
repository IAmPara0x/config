{ pkgs, lib, ... }:

{
  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      vim-surround
      auto-pairs
      vim-airline
      vim-airline-themes
      molokai
      vim-commentary
    ];
    settings = { ignorecase = true; };
    extraConfig =

      # vim
      ''
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

        filetype plugin indent on

        syntax enable
        colorscheme molokai
        let g:airline_theme='tomorrow'

        let mapleader =" "
        inoremap jk <Esc>
        nnoremap <leader>fs :update<cr>
        nnoremap Y y$

      '';
  };
}
