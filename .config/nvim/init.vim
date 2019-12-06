scriptencoding utf-8

" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set ambiwidth=double

" Fix backspace indent
set backspace=indent,eol,start

" Tabs, Indent
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab
set autoindent
set smartindent
set list

" Display
syntax on
set notitle
set showcmd
set laststatus=2
set ruler
set number
set showmatch

" Searching
set incsearch
set ignorecase
set smartcase
set hlsearch
set wrapscan

nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>

" Other
set nocompatible
set nobackup
set noswapfile
set nrformats=octal
set hidden
set autoread

" keymap
nnoremap j gj
nnoremap k gk
nnoremap <down> gj
nnoremap <up> gk

" dein
let s:dein_cache_path = expand('~/.cache/nvim/dein')
let s:dein_dir = s:dein_cache_path
      \ .'/repos/github.com/Shougo/dein.vim'

if &runtimepath !~ '/dein.vim'
  if !isdirectory(s:dein_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_dir
  endif
  execute 'set runtimepath+=' . fnamemodify(s:dein_dir, ':p')
endif

if dein#load_state(s:dein_cache_path)
  call dein#begin(s:dein_cache_path)

  call dein#load_toml('~/.config/nvim/dein.toml', {'lazy' : 0})
  call dein#load_toml('~/.config/nvim/dein_lazy.toml', {'lazy' : 1})

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

filetype plugin indent on
syntax enable
