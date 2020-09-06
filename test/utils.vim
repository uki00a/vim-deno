let s:suite = themis#suite("utils")
let s:assert = themis#helper("assert")

function! s:suite.is_test_file() abort
  for l:t in [
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
    let [l:given, l:expected] = l:t
    let l:actual = deno#utils#is_test_file(l:given)
    call s:assert.equals(
      \ l:actual,
      \ l:expected,
      \ "Given " . l:given . ", " . l:expected . " expected, but got " . l:actual)
  endfor
endfunction
