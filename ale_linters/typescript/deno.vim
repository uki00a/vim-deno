function! s:Executable(buffer) abort
  return get(g:, "deno_executable", "deno")
endfunction

function! s:Command(buffer) abort
  let l:cmd = printf(
  \ "%s lint --unstable --json",
  \ s:Executable(a:buffer)) . " %s"
  return l:cmd
endfunction

function! s:Callback(buffer, lines) abort
  if empty(a:lines)
    return []
  endif

  let l:qflist = deno#lint#convert_lint_result_into_qflist(json_decode(a:lines))
  return l:qflist
endfunction

call ale#linter#Define("typescript", {
\ "name": "deno",
\ "executable": function("s:Executable"),
\ "command": function("s:Command"),
\ "callback": function("s:Callback"),
\ "output_stream": "stderr",
\})
