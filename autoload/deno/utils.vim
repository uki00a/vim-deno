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
