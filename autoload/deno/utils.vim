function! deno#utils#resolve_filename_of_buffer(buf) abort
  return fnamemodify(expand("#" . a:buf), ":p")
endfunction

function! deno#utils#open_new_buffer(buffer_name) abort
  let l:buffer_name = join(["vim-deno", a:buffer_name], "/")
  let l:buf = bufnr(l:buffer_name, 1)
  let l:win = bufwinnr(l:buf)
  if l:win > -1
    execute l:win . "wincmd w"
  else
    silent! execute "split #" . l:buf
  endif
  return l:buf
endfunction

function! deno#utils#run_in_term(cmd) abort
  let l:job_opts = {
    \   "on_exit": function("s:OnExit"),
    \ }
  call termopen(a:cmd, l:job_opts) " TODO add support for the Vim
endfunction

function! s:OnExit(job_id, code, event) abort
  " TODO implement this!
endfunction

function! deno#utils#is_test_file(path) abort
  let l:basename = fnamemodify(a:path, ":t")
  return l:basename =~# "_test.ts$" ||
    \ l:basename == "test.ts" ||
    \ l:basename =~# "_test.tsx$" ||
    \ l:basename == "test.tsx" ||
    \ l:basename =~# "_test.js$" ||
    \ l:basename == "test.js" ||
    \ l:basename =~# "_test.jsx$" ||
    \ l:basename == "test.jsx"
endfunction

function! deno#utils#build_test_filename(path) abort
  let l:ext = fnamemodify(a:path, ":e")
  let l:without_ext = fnamemodify(a:path, ":r")
  let l:test_filename = l:without_ext . "_test." . l:ext
  return filereadable(l:test_filename) ? l:test_filename : a:path
endfunction
