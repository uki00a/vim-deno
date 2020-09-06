function! deno#test_buffer(buf) abort
  let l:file = deno#utils#resolve_filename_of_buffer(a:buf)
  let l:target_file = deno#utils#is_test_file(l:file)
    \ ? l:file
    \ : deno#utils#build_test_filename(l:file)
  let l:flags = "-A" " TODO add support for passing flags
  let l:cmd = printf("%s test %s %s", g:deno_executable, l:flags, l:target_file)
  call deno#utils#open_new_buffer("test")
  call deno#utils#run_in_term(l:cmd)
endfunction

function! deno#doc_buffer(buf) abort
  let l:file = deno#utils#resolve_filename_of_buffer(a:buf)
  let l:cmd = printf("%s doc %s", g:deno_executable, l:file)
  call deno#utils#open_new_buffer("doc")
  call deno#utils#run_in_term(l:cmd)
endfunction

function! deno#fmt_buffer(buf) abort
  let l:contents = deno#utils#get_contents_of_buffer(a:buf)
  let l:cmd = printf("%s fmt -", g:deno_executable)
  let l:output = system(l:cmd, l:contents)
  " Cleanup the current buffer
  :%delete
  call setline(1, split(l:output, "\n"))
endfunction

function! deno#lint_buffer(buf) abort
  let l:cmd = printf(
    \ "%s lint --unstable --json -",
    \ g:deno_executable)
  let l:contents = deno#utils#get_contents_of_buffer(a:buf)
  let l:lint_result = json_decode(system(l:cmd, l:contents))
  let l:qflist = deno#lint#convert_lint_result_into_qflist(l:lint_result)
  call setqflist(l:qflist, " ")
  copen
endfunction
