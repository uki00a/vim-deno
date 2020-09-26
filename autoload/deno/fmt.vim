function! deno#fmt#Command(args) abort
  return deno#config#Command("fmt", a:args)
endfunction
