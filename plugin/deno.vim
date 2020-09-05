scriptencoding utf-8

if exists("g:loaded_vim_deno")
  finish
endif
let g:loaded_vim_deno = 1

let s:cpo_save = &cpo
set cpo&vim

let s:deno_executable = get(g:, "deno_executable", "deno")

function! s:DenoTest() abort
  let l:file = fnamemodify(expand("%"), ":p")
  let l:target_file = deno#utils#is_test_file(l:file)
    \ ? l:file
    \ : deno#utils#build_test_filename(l:file)
  let l:flags = "-A" " TODO add support for passing flags
  let l:cmd = printf("%s test %s %s", s:deno_executable, l:flags, l:target_file)
  call deno#utils#open_new_buffer("test")
  call deno#utils#run_in_term(l:cmd)
endfunction

function! s:DenoFmt() abort
  let l:contents = join(getline(1, "$"), "\n")
  let l:cmd = printf("%s fmt -", s:deno_executable)
  let l:output = system(l:cmd, l:contents)
  " Cleanup the current buffer
  :%delete
  call setline(1, split(l:output, "\n"))
endfunction

function! s:DenoDoc() abort
  let l:file = fnamemodify(expand("%"), ":p")
  let l:cmd = printf("%s doc %s", s:deno_executable, l:file)
  call deno#utils#open_new_buffer("doc")
  call deno#utils#run_in_term(l:cmd)
endfunction
" TODO DenoLint
command! DenoFmt call s:DenoFmt()
" TODO Add support for passing flags
command! DenoTest call s:DenoTest()
command! DenoDoc call s:DenoDoc()

let &cpo = s:cpo_save
unlet s:cpo_save
