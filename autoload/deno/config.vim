function! deno#config#Executable() abort
  return get(g:, "deno_executable", "deno")
endfunction

function! deno#config#Command(subcommand, args) abort
  return printf(
    \ "%s %s %s",
    \ deno#config#Executable(),
    \ a:subcommand,
    \ join(a:args, " "))
endfunction
