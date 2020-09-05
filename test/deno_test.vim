let s:suite = themis#suite("deno test")
let s:assert = themis#helper("assert")

function! s:suite.after_each() abort
  :%bwipeout!
endfunction

function! s:suite.command() abort
  call OpenTestdataFile("sum.ts")
  DenoTest
  " FIXME wait until "deno test" is done...
  sleep 3
  call s:assert.match(bufname("%"), "sum_test.ts")
  let l:contents = trim(join(getline(1, "$")), "\n")
  let
  call s:assert.match(l:contents, "test sum() ... ok")
endfunction