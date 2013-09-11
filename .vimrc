" === 文字コードまわり ===
" 内部エンコーディング
set encoding=utf-8
" ファイルエンコーディング
set fileencoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,cp932
" 改行コード
set fileformats=unix
" vimが認識する文字幅を調整する
if &encoding == 'utf-8'
  set ambiwidth=double
endif

" === 検索まわり ===
" 検索時に大文字・小文字を無視(ignorecase: 無視しない)
set ignorecase
" 大文字・小文字の両方が含まれている場合は、区別する
set smartcase
" インクリメンタルサーチ
set incsearch
" マッチした箇所をハイライト
set hlsearch
" 検索時にファイルの最後まで言ったら最初に戻る(nowrapscan:戻らない)
set wrapscan

" === 表示まわり ===
" タイトルを表示しない(Thanks for flying Vim 対策)
set notitle
" 入力中のコマンドを表示
set showcmd
" 括弧入力時に対応する括弧を表示(noshowmatch:表示しない)
set showmatch
" 常にステータス行を表示する
set laststatus=2
" ステータスラインに文字コードと改行コード表示
"set statusline=%F%m%r%h%w\ [%{&fenc!=''?&fenc:&enc}]\[%{&ff}]\%=\[%l/%L]
" オートインデント
set autoindent
" C言語のコードを自動的にインデントする
set cindent
" カーソル行を表示
set ruler
" 行番号を表示
set number
" Tabを明示的に表示させる
set listchars=tab:__
set list
" Tab文字を画面上の見た目で何文字に展開するか
set tabstop=4
" インデント時に挿入されるTabの幅
set shiftwidth=4
" インデントをTabではなくスペースにする
set expandtab
" 全角スペースをハイライト
augroup highlightldegraphicSpace
  autocmd!
  autocmd ColorScheme * highlight ldeographicSpace term=underline ctermbg=DarkGreen guibg=DarkGreen
  autocmd VimEnter,WinEnter * match ldeographicSpace /　/
augroup END

" === 機能まわり ===
" vi互換モードにしない
set nocompatible
" バックアップファイルを作らない
set nobackup
" スワップファイル作らない
set noswapfile
" コマンドライン補完するときに強化されたものを使う
set wildmenu
"<BS>キーがつかえる範囲
set backspace=indent,eol,start
" バックスペースキーを有効にする
set t_kd=<BS>
" デリートキーを有効にする
set t_kD=<Del>
" Ctrl-A の8進数計算を抑制
set nrformats=octal
" 折りたたみオプション
set foldmethod=marker
" 埋め込まれるマーカーを囲むコメントの形式を変更
set commentstring=//%s
" 折りたたみコマンドのショートカット
nmap c :%foldclose<CR>
" 検索結果のハイライトの停止
nmap <ESC><ESC> :nohlsearch<CR>
" マウスの設定
set mouse=a
set ttymouse=xterm2
" 保存時に行末の空白を削除する
augroup removeEndSpace
  autocmd!
  autocmd BufWritePre * :%s/\s\+$//ge
augroup END
" .vimrc を開く
nnoremap ,. :tabnew $MYVIMRC<CR>
" .vimrc の即時反映
nnoremap ,s. :<C-u>source $MYVIMRC<CR>

" === テンプレート ===
augroup template
  autocmd!
  " .php
  autocmd BufNewFile *.php 0r $HOME/.vim/template/php_template.txt
  " .inc
  autocmd BufNewFile *.inc 0r $HOME/.vim/template/php_template.txt
augroup END

" === PHP 設定 ===
augroup phpsyntaxcheck
  autocmd!
  autocmd BufWrite *.php w !php -l
  autocmd BufWrite *.inc w !php -l
augroup END

" === Plugins ===
" neobundle
" $ git clone git://github.com/Shougo/neobundle.vim.git ~/.vim/bundle/neobundle.vim
filetype off
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#rc(expand('~/.vim/bundle'))
endif
filetype plugin indent on

function! s:bundle_tap(bundle)
  let s:tapped_bundle = neobundle#get(a:bundle)
  return neobundle#is_installed(a:bundle)
endfunction

function! s:bundle_config(config)
  if exists("s:tapped_bundle") && s:tapped_bundle != {}
    call neobundle#config(s:tapped_bundle.name, a:config)
  endif
endfunction

function! s:bundle_untap()
  let s:tapped_bundle = {}
endfunction

" -- Plugin list --
NeoBundle 'git://github.com/Shougo/neobundle.vim.git'
NeoBundle 'git://github.com/Shougo/neocomplcache.git'
NeoBundle 'git://github.com/thinca/vim-quickrun.git'
NeoBundle 'git://github.com/thinca/vim-ref.git'
NeoBundle 'git://github.com/Shougo/vimshell.git'
NeoBundle 'git://github.com/tpope/vim-markdown.git'
NeoBundle 'git://github.com/tsaleh/vim-align.git'
NeoBundle 'git://github.com/altercation/vim-colors-solarized.git'
NeoBundle 'git://github.com/scrooloose/nerdtree.git'
NeoBundle 'git://github.com/tpope/vim-fugitive.git'
NeoBundle 'git://github.com/StanAngeloff/php.vim.git'
NeoBundle 'git://github.com/vim-scripts/sudo.vim.git'
NeoBundle 'git://github.com/Shougo/unite.vim.git'
NeoBundle 'git://github.com/h1mesuke/unite-outline.git'
NeoBundle 'git://github.com/airblade/vim-gitgutter.git'
NeoBundle 'git://github.com/itchyny/lightline.vim.git'
NeoBundle 'git://github.com/gregsexton/gitv.git'
NeoBundle 'git://github.com/vim-scripts/taglist.vim.git'
NeoBundle 'git://github.com/sjl/gundo.vim.git'
NeoBundle 'git://github.com/Shougo/vimproc.git', {
          \   'build' : {
          \       'windows' : 'make -f make_mingw32.mak',
          \       'cygwin' : 'make -f make_cygwin.mak',
          \       'mac' : 'make -f make_mac.mak',
          \       'unix' : 'make -f make_unix.mak',
          \   },
          \}

" === Plugin Settings ===
" neocomplcache
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_min_syntax_length = 3
augroup neocomplcache_settings
  autocmd!
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown,xml setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType php setlocal omnifunc=phpscriptcomplete#CompletePHP
  autocmd FileType c setlocal omnifunc=ccomplete#Complete
augroup END

" quickrun
augroup QuickRunPHPUnit
  autocmd!
  autocmd BufWinEnter,BufNewFile *Test.php set filetype=phpunit.php
augroup END

let g:quickrun_config = {'markdown': {'command': 'convert_md'}}
let g:quickrun_config = {
            \   '_' : {
            \       'runner': 'vimproc',
            \       'runner/vimproc/updatetime': 60,
            \       'outputter': 'multi:buffer:quickfix',
            \       'outputter/buffer/append': 1,
            \       'outputter/buffer/into': 0
            \   },
            \   'phpunit.php': {
            \       'command': './vendor/bin/phpunit',
            \       'exec': '%c %o %s'
            \   },
            \   'markdown': {
            \       'command': 'convert_md'
            \   }
            \}

            "\       'outputter/buffer/split': ':botright 7sp',
" taglist
let Tlist_Ctags_Cmd = "/usr/bin/ctags"
let Tlist_Show_One_File = 1
let Tlist_Use_Right_Window = 1
let Tlist_Exit_OnlyWindow = 1
map <silent> <C-l> :TlistToggle<CR>

" gitgutter
nnoremap <silent> ,gg :<C-u>GitGutterToggle<CR>

" vim-ref
let g:ref_phpmanual_path = $HOME."/.vim/dict/phpmanual"
map <C-m> :Ref phpmanual <C-r><C-w><CR>

" solarized
syntax enable
set background=dark
"set background=light
colorscheme solarized
let g:solarized_termcolors=256

" NERD Tree
let file_name = expand("%")
if has('vim_starting') && file_name == ""
  autocmd VimEnter * NERDTree ./
endif
nnoremap <silent> <C-e> :NERDTreeToggle<CR>

" lightline
let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'mode_map': { 'c': 'NORMAL' },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
      \ },
      \ 'component_function': {
      \   'modified': 'MyModified',
      \   'readonly': 'MyReadonly',
      \   'fugitive': 'MyFugitive',
      \   'filename': 'MyFilename',
      \   'fileformat': 'MyFileformat',
      \   'filetype': 'MyFiletype',
      \   'fileencoding': 'MyFileencoding',
      \   'mode': 'MyMode',
      \ },
      \ 'separator': { 'left': '⮀', 'right': '⮂' },
      \ 'subseparator': { 'left': '⮁', 'right': '⮃' }
      \ }

function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &ro ? '⭤' : ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
       \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
       \  &ft == 'unite' ? unite#get_status_string() :
       \  &ft == 'vimshell' ? substitute(b:vimshell.current_dir,expand('~'),'~','') :
       \ '' != expand('%t') ? expand('%t') : '[No Name]') .
       \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  return &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head') && len(fugitive#head()) ? '⭠ '.fugitive#head() : ''
endfunction

function! MyFileformat()
  return winwidth('.') > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth('.') > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth('.') > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  return winwidth('.') > 60 ? lightline#mode() : ''
endfunction
