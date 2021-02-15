augroup NerdtreeSettingGroup
    autocmd!
augroup END

let g:NERDTreeShowHidden = 1

let file_name = expand("%")
if has('vim_starting') && file_name == ""
    autocmd NerdtreeSettingGroup VimEnter * NERDTree ./
endif
nnoremap <silent> <C-e> :NERDTreeToggle<CR>
