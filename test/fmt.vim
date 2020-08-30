let s:suite = themis#suite("deno fmt")
let s:assert = themis#helper("assert")

function! s:suite.after_each() abort
  bw!
endfunction

function! s:suite.DenoFmt() abort
  " FIXME
  edit test/testdata/fmt.ts
  let l:previous_contents = join(getline(1, "$"), "\n")
  DenoFmt
  let l:current_contents = join(getline(1, "$"), "\n")
  call s:assert.not_equals(l:previous_contents, l:current_contents)
endfunction
