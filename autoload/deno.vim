let s:deno_executable = get(g:, "deno_executable", "deno")

function! deno#test(file) abort
  let l:target_file = deno#utils#is_test_file(a:file)
    \ ? a:file
    \ : deno#utils#build_test_filename(a:file)
  let l:flags = "-A" " TODO add support for passing flags
  let l:cmd = printf("%s test %s %s", s:deno_executable, l:flags, l:target_file)
  call deno#utils#open_new_buffer("test")
  call deno#utils#run_in_term(l:cmd)
endfunction

function! deno#doc(file) abort
  let l:cmd = printf("%s doc %s", s:deno_executable, a:file)
  call deno#utils#open_new_buffer("doc")
  call deno#utils#run_in_term(l:cmd)
endfunction

function! deno#fmt(contents) abort
  let l:cmd = printf("%s fmt -", s:deno_executable)
  let l:output = system(l:cmd, a:contents)
  " Cleanup the current buffer
  :%delete
  call setline(1, split(l:output, "\n"))
endfunction
