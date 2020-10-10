function! deno#term#Open(cmd) abort
  call s:OpenNewBuffer()
  call s:Open(a:cmd)
endfunction

function! s:OpenNewBuffer() abort
  let l:buffer_name = "__vim-deno__"
  let l:buf = bufnr(l:buffer_name, 1)
  let l:win = bufwinnr(l:buf)
  if l:win > -1
    execute l:win . "wincmd w"
  else
    silent! execute "split #" . l:buf
  endif
  return l:buf
endfunction

function! s:Open(cmd) abort
  let l:job_opts = {
    \   "on_exit": function("s:OnExit"),
    \ }
  call termopen(a:cmd, l:job_opts) " TODO add support for the Vim
endfunction

function! s:OnExit(job_id, code, event) abort
  " TODO implement this!
endfunction

