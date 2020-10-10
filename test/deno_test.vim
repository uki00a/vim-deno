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
  call s:assert.match(l:contents, "test sum() ... ok")
endfunction

function! s:suite.IsTestFile() abort
  for [l:given, l:expected] in [
  \   ["test.ts", v:true],
  \   ["test.js", v:true],
  \   ["test.tsx", v:true],
  \   ["test.jsx", v:true],
  \   ["a_test.ts", v:true],
  \   ["b_test.js", v:true],
  \   ["c_test.tsx", v:true],
  \   ["d_test.jsx", v:true],
  \   ["path/to/hoge_test.ts", v:true],
  \   ["piyo.ts", v:false],
  \   ["fuga.js", v:false],
  \   ["hoge.tsx", v:false],
  \   ["foo.jsx", v:false],
  \   ["path/to/sum.ts", v:false],
  \ ]
    let l:actual = deno#test#IsTestFile(l:given)
    call s:assert.equals(
      \ l:actual,
      \ l:expected,
      \ "Given " . l:given . ", " . l:expected . " expected, but got " . l:actual)
  endfor
endfunction
