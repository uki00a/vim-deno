function! deno#doc#Command(args) abort
  return deno#config#Command("doc", a:args)
endfunction

function! deno#doc#ShowDocForBuffer(buf) abort
  let l:file = deno#utils#ResolveFilenameOfBuffer(a:buf)
  let l:cmd = deno#doc#Command([l:file])
  call deno#term#Open(l:cmd)
endfunction
