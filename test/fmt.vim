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
  let l:current_contents = trim(join(getline(1, "$"), "\n"))
  let l:expected_contents = trim(system("deno fmt -", l:previous_contents))
  call s:assert.equals(l:current_contents, l:expected_contents)
endfunction
