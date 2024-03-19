scriptencoding utf-8
if exists('g:load_FzfGrep')
  finish
endif
let g:load_FzfGrep = 1

let s:save_cpo = &cpo
set cpo&vim

nnoremap <silent> <Plug>fzf-grep-run :lua require('FzfGrep').run("")<cr>
nnoremap <Tab>? <Plug>fzf-grep-run

let &cpo = s:save_cpo
unlet s:save_cpo

