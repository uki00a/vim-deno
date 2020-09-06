let s:suite = themis#suite("deno doc")
let s:assert = themis#helper("assert")

function! s:suite.after_each() abort
  :%bwipeout!
  call setqflist([], "f")
endfunction

function! s:suite.command() abort
  call OpenTestdataFile("lint.ts")
  DenoLint
  let l:qflist = getqflist()
  call s:assert.not_empty(l:qflist)

  let l:first_item = l:qflist[0]
  call s:assert.match(l:first_item.text, "`any` type is not allowed")
  call s:assert.equals(l:first_item.lnum, 1)
  call s:assert.equals(l:first_item.col, 32)
endfunction

