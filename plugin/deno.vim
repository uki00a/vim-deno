scriptencoding utf-8

if exists("g:loaded_vim_deno")
  finish
endif
let g:loaded_vim_deno = 1

let s:cpo_save = &cpo
set cpo&vim

command! DenoFmt call deno#fmt_buffer(bufnr())
" TODO Add support for passing flags
command! DenoTest call deno#test_buffer(bufnr()) 
command! DenoDoc call deno#doc_buffer(bufnr())
command! DenoLint call deno#lint_buffer(bufnr())

let &cpo = s:cpo_save
unlet s:cpo_save
