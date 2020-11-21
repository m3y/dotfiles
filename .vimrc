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
set list listchars=tab:_\ 

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

" Terminal
nnoremap <C-t> :bo terminal ++rows=15<CR>
command! Terminal call popup_create(term_start([&shell], #{ hidden: 1, term_finish: 'close'}), #{ border: [], minwidth: winwidth(0)/2, minheigh: &lines/2 })

" Other
set nocompatible
set nobackup
set noswapfile
set nrformats=octal
set hidden
set autoread
" Disable fold
set foldmethod=syntax
set foldlevel=100

" keymap
nnoremap j gj
nnoremap k gk
nnoremap <down> gj
nnoremap <up> gk

if !has('gui_running')
  augroup opacity
    autocmd!
    autocmd VimEnter,ColorScheme * highlight Normal ctermbg=none
    autocmd VimEnter,ColorScheme * highlight LineNr ctermbg=none
    autocmd VimEnter,ColorScheme * highlight SignColumn ctermbg=none
    autocmd VimEnter,ColorScheme * highlight VertSplit ctermbg=none
    autocmd VimEnter,ColorScheme * highlight NonText ctermbg=none
  augroup END
endif

" template
augroup template
  autocmd!
  autocmd BufNewFile *.py 0r ${HOME}/.vim/templates/python_template.txt
  autocmd BufNewFile *.go 0r ${HOME}/.vim/templates/go_template.txt
  autocmd BufNewFile *.sh 0r ${HOME}/.vim/templates/sh_template.txt
augroup END

" dein
let s:dein_cache_path = expand('~/.cache/vim/dein')
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

  call dein#load_toml('~/.vim/rc/dein.toml', {'lazy' : 0})
  call dein#load_toml('~/.vim/rc/dein_lazy.toml', {'lazy' : 1})

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

filetype plugin indent on
syntax enable
