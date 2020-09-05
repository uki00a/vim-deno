let s:suite = themis#suite("deno doc")
let s:assert = themis#helper("assert")

function! s:suite.after_each() abort
  :%bwipeout!
endfunction

function! s:suite.command() abort
  call OpenTestdataFile("sum.ts")
  DenoDoc
  " FIXME wait until "deno test" is done...
  sleep 3
  let l:contents = trim(join(getline(1, "$")), "\n")
  call s:assert.match(l:contents, "function sum(...numbers: number[]): number")
endfunction
