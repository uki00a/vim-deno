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
  let l:target_file = s:is_test_file(l:file)
    \ ? l:file
    \ : s:build_test_filename(l:file)
  let l:flags = "-A" " TODO add support for passing flags
  let l:cmd = printf("%s test %s %s", s:deno_executable, l:flags, l:target_file)
  let l:job_opts = {
    \   "on_exit": function("s:OnExit"),
    \   "cwd": fnamemodify(l:target_file, ":h")
    \ }
  echomsg l:cmd
  call termopen(l:cmd, l:job_opts) " TODO add support for the Vim
endfunction

function! s:OnExit(job_id, code, event) abort
  " TODO implement this!
endfunction

function! s:DenoFmt() abort
  let l:contents = join(getline(1, "$"), "\n")
  let l:cmd = printf("%s fmt -", s:deno_executable)
  let l:output = system(l:cmd, l:contents)
  " Cleanup the current buffer
  :%delete
  call setline(1, split(l:output, "\n"))
endfunction

function! s:is_test_file(path) abort
  let l:basename = fnamemodify(a:path, ":t")
  return l:basename =~ "_test.ts$" ||
    \ l:basename == "test.ts" ||
    \ l:basename =~ "_test.tsx$" ||
    \ l:basename == "test.tsx" ||
    \ l:basename =~ "_test.js$" ||
    \ l:basename == "test.js" ||
    \ l:basename =~ "_test.jsx$" ||
    \ l:basename == "test.jsx"
endfunction

function! s:build_test_filename(path) abort
  let l:ext = fnamemodify(a:path, ":e")
  let l:without_ext = fnamemodify(a:path, ":r")
  let l:test_filename = l:without_ext . "_test." . l:ext
  return filereadable(l:test_filename) ? l:test_filename : a:path
endfunction

" TODO DenoDoc, DenoLint, etc.
command! DenoFmt call s:DenoFmt()
" TODO Add support for passing flags
command! DenoTest call s:DenoTest()

let &cpo = s:cpo_save
unlet s:cpo_save
