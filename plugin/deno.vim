scriptencoding utf-8

if exists("g:loaded_vim_deno")
  finish
endif
let g:loaded_vim_deno = 1

let s:cpo_save = &cpo
set cpo&vim

command! DenoFmt call deno#fmt(join(getline(1, "$"), "\n"))
" TODO Add support for passing flags
command! DenoTest call deno#test(fnamemodify(expand("%"), ":p")) 
command! DenoDoc call deno#doc(fnamemodify(expand("%"), ":p"))
command! DenoLint call deno#lint(fnamemodify(expand("%"), ":p"))

let &cpo = s:cpo_save
unlet s:cpo_save
