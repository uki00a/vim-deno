function! deno#TestBuffer(buf) abort
  let l:file = deno#utils#ResolveFilenameOfBuffer(a:buf)
  let l:target_file = deno#utils#IsTestFile(l:file)
    \ ? l:file
    \ : deno#utils#BuildTestFilename(l:file)
  let l:flags = "-A" " TODO add support for passing flags
  let l:cmd = printf("%s test %s %s", g:deno_executable, l:flags, l:target_file)
  call deno#utils#OpenNewBuffer("test")
  call deno#utils#RunInTerm(l:cmd)
endfunction

function! deno#DocBuffer(buf) abort
  let l:file = deno#utils#ResolveFilenameOfBuffer(a:buf)
  let l:cmd = printf("%s doc %s", g:deno_executable, l:file)
  call deno#utils#OpenNewBuffer("doc")
  call deno#utils#RunInTerm(l:cmd)
endfunction

function! deno#FmtBuffer(buf) abort
  let l:contents = deno#utils#GetContentsOfBuffer(a:buf)
  let l:cmd = printf("%s fmt -", g:deno_executable)
  let l:output = system(l:cmd, l:contents)
  " Cleanup the current buffer
  :%delete
  call setline(1, split(l:output, "\n"))
endfunction

function! deno#LintBuffer(buf) abort
  let l:cmd = printf(
    \ "%s lint --unstable --json -",
    \ g:deno_executable)
  let l:contents = deno#utils#GetContentsOfBuffer(a:buf)
  let l:lint_result = json_decode(system(l:cmd, l:contents))
  let l:qflist = deno#lint#ConvertLintResultIntoQflist(l:lint_result)
  call setqflist(l:qflist, " ")
  copen
endfunction
