function! deno#fmt#Command(args) abort
  return deno#config#Command("fmt", a:args)
endfunction

function! deno#fmt#FormatBuffer(buf) abort
  let l:contents = deno#utils#GetContentsOfBuffer(a:buf)
  let l:cmd = deno#fmt#Command(["-"])
  call deno#child_process#Exec(l:cmd, l:contents, function("s:FormatCallback", [a:buf]))
endfunction

function! s:FormatCallback(buf, err, contents) abort
  if a:err == v:null
    call deletebufline(a:buf, 1, "$")
    call setbufline(a:buf, 1, split(a:contents, "\n"))
  else
    " TODO error handling
  endif
endfunction
