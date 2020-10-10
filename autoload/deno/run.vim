function! deno#run#Command(args) abort
  return deno#config#Command("run", a:args)
endfunction

function! deno#run#RunBuffer(buf) abort
  let l:flags = "-A" " TODO add support for passing flags
  let l:target_file = deno#utils#ResolveFilenameOfBuffer(a:buf)
  let l:cmd = deno#run#Command([l:flags, l:target_file])
  call deno#term#Open(l:cmd)
endfunction
