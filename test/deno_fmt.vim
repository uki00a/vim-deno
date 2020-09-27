let s:suite = themis#suite("deno fmt")
let s:assert = themis#helper("assert")

function! s:suite.after_each() abort
  :%bwipeout!
endfunction

function! s:suite.command() abort
  call OpenTestdataFile("fmt.ts")
  let l:previous_contents = join(getline(1, "$"), "\n")
  DenoFmt
  let l:expected_contents = trim(system("deno fmt -", l:previous_contents))
  " FIXME wait until "deno fmt" is done...
  sleep 3
  let l:current_contents = trim(join(getline(1, "$"), "\n"))
  call s:assert.equals(l:current_contents, l:expected_contents)
endfunction
