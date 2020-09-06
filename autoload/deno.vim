let s:deno_executable = get(g:, "deno_executable", "deno")

function! deno#test_buffer(buf) abort
  let l:file = deno#utils#resolve_filename_of_buffer(a:buf)
  let l:target_file = deno#utils#is_test_file(l:file)
    \ ? l:file
    \ : deno#utils#build_test_filename(l:file)
  let l:flags = "-A" " TODO add support for passing flags
  let l:cmd = printf("%s test %s %s", s:deno_executable, l:flags, l:target_file)
  call deno#utils#open_new_buffer("test")
  call deno#utils#run_in_term(l:cmd)
endfunction

function! deno#doc_buffer(buf) abort
  let l:file = deno#utils#resolve_filename_of_buffer(a:buf)
  let l:cmd = printf("%s doc %s", s:deno_executable, l:file)
  call deno#utils#open_new_buffer("doc")
  call deno#utils#run_in_term(l:cmd)
endfunction

function! deno#fmt_buffer(buf) abort
  let l:contents = join(getbufline(a:buf, 1, "$"), "\n")
  let l:cmd = printf("%s fmt -", s:deno_executable)
  let l:output = system(l:cmd, l:contents)
  " Cleanup the current buffer
  :%delete
  call setline(1, split(l:output, "\n"))
endfunction

function! deno#lint_buffer(buf) abort
  let l:file = deno#utils#resolve_filename_of_buffer(a:buf)
  let l:cmd = printf(
    \ "%s lint --unstable --json %s",
    \ s:deno_executable,
    \ l:file)
  let l:lint_result = json_decode(system(l:cmd))
  let l:qflist = s:convert_lint_result_into_qflist(l:lint_result)
  call setqflist(l:qflist, " ")
  copen
endfunction

function! s:convert_lint_result_into_qflist(result) abort
  let l:errors = map(a:result.errors, '{
    \   "filename": v:val.filename,
    \   "lnum": v:val.location.line,
    \   "col": v:val.location.col + 1,
    \   "text": v:val.message,
    \   "pattern": v:val.code,
    \   "type": "E",
    \ }')
  let l:diagnostics = map(a:result.diagnostics, '{
    \   "filename": v:val.filename,
    \   "lnum": v:val.location.line,
    \   "col": v:val.location.col + 1,
    \   "text": v:val.message,
    \   "pattern": v:val.code,
    \   "type": "W",
    \ }')
  return extend(l:errors, l:diagnostics)
endfunction
