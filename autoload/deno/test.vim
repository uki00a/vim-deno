function! deno#test#Command(args) abort
  return deno#config#Command("test", a:args)
endfunction

function! deno#test#TestBuffer(buf) abort
  let l:file = deno#utils#ResolveFilenameOfBuffer(a:buf)
  let l:target_file = deno#test#IsTestFile(l:file)
    \ ? l:file
    \ : deno#test#BuildTestFilename(l:file)
  let l:flags = "-A" " TODO add support for passing flags
  let l:cmd = deno#test#Command([l:flags, l:target_file])
  call deno#term#Open(l:cmd)
endfunction

function! deno#test#IsTestFile(path) abort
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

function! deno#test#BuildTestFilename(path) abort
  let l:ext = fnamemodify(a:path, ":e")
  let l:without_ext = fnamemodify(a:path, ":r")
  let l:test_filename = l:without_ext . "_test." . l:ext
  return filereadable(l:test_filename) ? l:test_filename : a:path
endfunction
