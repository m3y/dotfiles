if !exists("g:quickrun_config")
  let g:quickrun_config={}
endif

let g:quickrun_config = {
  \  "_" : {
  \    "outputter/buffer/split" : "rightbelow 12sp",
  \    "outputter/error/error" : "quickfix",
  \    "outputter/error/success" : "buffer",
  \    "outputter" : "error",
  \  }
  \}

augroup rust_quickrun
  au!
  autocmd BufNewFile,BufRead *.rs let g:quickrun_config.rust = {'exec' : 'cargo run'}
augroup END
