scriptencoding utf-8

if exists("g:loaded_vim_deno")
  finish
endif
let g:loaded_vim_deno = 1

let s:cpo_save = &cpo
set cpo&vim

let g:deno_executable = get(g:, "deno_executable", "deno")

command! DenoFmt call deno#FmtBuffer(bufnr())
" TODO Add support for passing flags
command! DenoTest call deno#TestBuffer(bufnr()) 
command! DenoDoc call deno#DocBuffer(bufnr())
command! DenoLint call deno#LintBuffer(bufnr())

let &cpo = s:cpo_save
unlet s:cpo_save
