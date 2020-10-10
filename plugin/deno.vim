scriptencoding utf-8

if exists("g:loaded_vim_deno")
  finish
endif
let g:loaded_vim_deno = 1

let s:cpo_save = &cpo
set cpo&vim

if exists("*ale#fix#registry#Add")
  deno#ale#AddFixer()
endif

command! DenoFmt call deno#fmt#FormatBuffer(bufnr())
" TODO Add support for passing flags
command! DenoTest call deno#test#TestBuffer(bufnr())
command! DenoDoc call deno#doc#ShowDocForBuffer(bufnr())
command! DenoLint call deno#lint#LintBuffer(bufnr())

let &cpo = s:cpo_save
unlet s:cpo_save
