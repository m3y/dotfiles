set encoding=utf-8
scriptencoding utf-8

" 文字コード
" ----------
set fileencoding=utf-8 " 保存時の文字コード
set fileencodings=ucs-boms,utf-8,euc-jp,cp932 " 読み込み時の文字コードの自動判別、左側優先
set fileformats=unix,mac,dos " 改行コードの自動判別、左側優先
set ambiwidth=double " □や○が崩れる問題を解決

" タブ・インデント
" ----------------
set expandtab " タブ入力を複数の空白入力に置き換える
set tabstop=4 " 画面上でタブ文字が占める幅
set softtabstop=4 " 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent " 改行時に前の行のインデントを継続する
set smartindent " 改行時に前の行の構文をチェックし次の行のインデントを増減する
set shiftwidth=4 " smartindent で増減する幅
set listchars=tab:-- " タブを明示的に表示させる
set list

" 表示周り
" --------
set notitle " タイトル非表示
set showcmd " 入力中のコマンド表示
set laststatus=2 " 常にステータス行を表示する

" 文字列検索
" ----------
set incsearch " インクリメンタルサーチ、１文字入力ごとに検索を行う
set ignorecase " 検索パターンの大文字小文字を区別しない
set smartcase " 検索パターンに大文字を含んでいたら大文字小文字を区別する
set hlsearch " 検索結果をハイライト
set wrapscan " 検索時にファイルの最後まで行ったら最初に戻る (-> nowrapscan:戻らない)

" ESCキー2度押しでハイライトの切り替え
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>

" カーソル
" --------
set whichwrap=b,s,h,l,<,>,[,],~ " カーソルの左右移動で行末から次の行の行頭への移動が可能になる
set number " 行番号を表示
set cursorline " カーソルラインをハイライト

" 行が折り返し表示されていた場合、行単位ではなく表示行単位でカーソルを移動する
nnoremap j gj
nnoremap k gk
nnoremap <down> gj
nnoremap <up> gk

" バックスペースの有効化
set backspace=indent,eol,start

" カッコ・タグジャンプ
" --------------------
set showmatch " カッコの対応関係を一瞬表示する
source $VIMRUNTIME/macros/matchit.vim " Vimの「%」を拡張する

" コマンド補完
" ------------
set wildmenu " コマンドモードの補完
set history=5000 " 保存するコマンド履歴の数

" マウスの有効化
" --------------
if has('mouse')
    set mouse=a
    if has('mouse_sgr')
        set ttymouse=sgr
    elseif v:version > 703 || v:version is 703 && has('patcht632')
        set ttymouse=sgr
    else
        set ttymouse=xterm2
    endif
endif

" ペースト設定
" ------------
if &term =~ "xterm"
    let &t_SI .= "\e[?2004h"
    let &t_EI .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif

" その他
" ------
set nocompatible " vi互換モードにしない
set nobackup " バックアップファイルを作らない
set noswapfile " スワップファイルを作らない
set nrformats=octal " Ctfl-A の8進数計算を抑制
set foldmethod=marker " 折りたたみオプション
set commentstring=//%s " 埋め込まれるマーカーを囲むコメントの形式を変更

" 折りたたみコマンドのショートカット
nmap c :%foldclose<CR>

" vimrc を開く
nnoremap ,. :tabnew $MYVIMRC<CR>
" vimrc の即時反映
nnoremap ,s. :<C-u>source $MYVIMRC<CR>

" terminal
autocmd * ColorScheme highlight Terminal ctermbg=none

" テンプレート
" -----------
augroup template
    autocmd!
    " .php
    autocmd BufNewFile *.php 0r $HOME/.vim/template/php_template.txt
    " .py
    autocmd BufNewFile *.py 0r $HOME/.vim/template/python_template.txt
augroup END

" Python 設定
" -----------
augroup pythonsetting
    autocmd!
    autocmd FileType python setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
augroup END

" Go 設定
" -------
augroup gosetting
    autocmd!
    autocmd FileType go setlocal noexpandtab tabstop=4 shiftwidth=4
    autocmd FileType go :highlight goErr cterm=bold ctermfg=214
    autocmd FileType go :match goErr /\<err\>/
augroup END

" Plugins
" =======
" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.vim/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'


" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
    if !isdirectory(s:dein_repo_dir)
        execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
    endif
    execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" 設定開始
if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)

    " プラグインリストを収めた TOML ファイル
    let g:rc_dir = expand('~/.vim/rc')
    let s:toml = g:rc_dir . '/dein.toml'
    let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

    " TOML を読み込み、キャッシュしておく
    call dein#load_toml(s:toml, {'lazy': 0})
    call dein#load_toml(s:lazy_toml, {'lazy': 1})

    " 設定終了
    call dein#end()
    call dein#save_state()
endif

if dein#check_install()
    call dein#install()
endif
