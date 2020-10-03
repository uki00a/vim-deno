function! deno#TestBuffer(buf) abort
  let l:file = deno#utils#ResolveFilenameOfBuffer(a:buf)
  let l:target_file = deno#utils#IsTestFile(l:file)
    \ ? l:file
    \ : deno#utils#BuildTestFilename(l:file)
  let l:flags = "-A" " TODO add support for passing flags
  let l:cmd = printf("%s test %s %s", deno#config#Executable(), l:flags, l:target_file)
  call deno#utils#OpenNewBuffer("test")
  call deno#utils#RunInTerm(l:cmd)
endfunction

function! deno#DocBuffer(buf) abort
  let l:file = deno#utils#ResolveFilenameOfBuffer(a:buf)
  let l:cmd = printf("%s doc %s", deno#config#Executable(), l:file)
  call deno#utils#OpenNewBuffer("doc")
  call deno#utils#RunInTerm(l:cmd)
endfunction
