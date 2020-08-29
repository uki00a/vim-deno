scriptencoding utf-8

if exists("g:loaded_vim_deno")
  finish
endif
let g:loaded_vim_deno = 1

let s:cpo_save = &cpo
set cpo&vim

let s:deno_executable = get(g:, "deno_executable", "deno")

function! s:DenoFmt() abort
  let l:file = expand("%")
  let l:contents = join(getline(1, "$"), "\n")
  let l:cmd = printf("%s fmt -", s:deno_executable)
  let l:output = system(l:cmd, l:contents)
  " Cleanup the current buffer
  :%delete
  call setline(1, split(l:output, "\n"))
endfunction

" TODO DenoTest, DenoDoc, DenoLint, etc.
command! DenoFmt call s:DenoFmt()

let &cpo = s:cpo_save
unlet s:cpo_save
