let s:root_dir = fnamemodify(expand("<sfile>:p"), ":p:h:h:h")

function! deno#utils#ResolveFromRootDir(path) abort
  return s:root_dir . a:path
endfunction

function! deno#utils#ResolveFilenameOfBuffer(buf) abort
  return fnamemodify(expand("#" . a:buf), ":p")
endfunction

function! deno#utils#GetContentsOfBuffer(buf) abort
  return join(getbufline(a:buf, 1, "$"), "\n")
endfunction

function! deno#utils#IsTestFile(path) abort
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

function! deno#utils#BuildTestFilename(path) abort
  let l:ext = fnamemodify(a:path, ":e")
  let l:without_ext = fnamemodify(a:path, ":r")
  let l:test_filename = l:without_ext . "_test." . l:ext
  return filereadable(l:test_filename) ? l:test_filename : a:path
endfunction
