augroup NerdtreeSettingGroup
    autocmd!
augroup END

let g:NERDTreeShowHidden = 1
let g:webdevicons_conceal_nerdtree_brackets = 1
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {}
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['vue'] = ''
let g:NERDTreeExtensionHighlightColor = {}
let g:NERDTreeExtensionHighlightColor['vue'] = '42B983'

let file_name = expand("%")
if has('vim_starting') && file_name == ""
    autocmd NerdtreeSettingGroup VimEnter * NERDTree ./
endif
nnoremap <silent> <C-e> :NERDTreeToggle<CR>
