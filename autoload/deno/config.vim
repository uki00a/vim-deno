function! deno#config#Executable() abort
  return get(g:, "deno_executable", "deno")
endfunction
