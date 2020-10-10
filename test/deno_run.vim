let s:suite = themis#suite("deno run")
let s:assert = themis#helper("assert")

function! s:suite.after_each() abort
  :%bwipeout!
endfunction

function! s:suite.command() abort
  call OpenTestdataFile("run.ts")
  DenoRun
  " FIXME wait until "deno run" is done...
  sleep 3
  let l:contents = trim(join(getline(1, "$")), "\n")
  call s:assert.match(l:contents, "500") " TODO add more assertions
endfunction
