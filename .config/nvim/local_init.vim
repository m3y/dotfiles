set ambiwidth=double " マルチバイト文字が崩れる問題を解決
set autoindent " 改行時に前の行のインデントを継続する
set smartindent " 改行時に前の行の構文をチェックし次の行のインデントを増減する
" set listchars=tab:__ " タブを明示的に表示させる
set list
set showcmd " 入力中のコマンド表示
set hlsearch " 検索結果をハイライト
set wrapscan " 検索時にファイルの最後まで行ったら最初に戻る (-> nowrapscan:戻らない)
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR> " ESCキー2度押しでハイライトの切り替え
set nrformats=octal " Ctfl-A の8進数計算を抑制
set foldmethod=marker " 折りたたみオプション
set commentstring=//%s " 埋め込まれるマーカーを囲むコメントの形式を変更

" NERDTree
augroup NerdtreeSettingGroup
    autocmd!
augroup END

let NERDTreeShowHidden = 1
let file_name = expand("%")
if has('vim_starting') && file_name == ""
    autocmd NerdtreeSettingGroup VimEnter * NERDTree ./
endif
nnoremap <silent> <C-e> :NERDTreeToggle<CR>

" taglist
let Tlist_Ctags_Cmd = "/usr/bin/ctags"
let Tlist_Show_One_File = 1
let Tlist_Use_Right_Window = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Enable_Fold_Column = 1
let Tlist_Auto_Open = 0
let Tlist_Auto_Update = 1
let Tlist_WinWidth = 30
map <silent> <C-l> :TlistToggle<CR>

" Solarized
if !exists('g:not_finish_vimplug')
  colorscheme solarized
endif

" Airline theme
let g:airline_theme = 'solarized'
let g:airline_solarized_bg='dark'
