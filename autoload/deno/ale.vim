" [Experimental]
function! deno#ale#Fix(buffer) abort
  return {
  \  "command": deno#fmt#Command(["-"]),
  \  "read_buffer": 1,
  \}
endfunction

" [Experimental]
function! deno#ale#AddFixer() abort
  call ale#fix#registry#Add(
    \ "deno",
    \ "deno#ale#Fix",
    \ ["typescript", "javascript"],
    \ "Apply deno fmt to a file.")
endfunction
