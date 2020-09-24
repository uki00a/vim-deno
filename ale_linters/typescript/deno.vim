function! s:Executable(buffer) abort
  return get(g:, "deno_executable", "deno")
endfunction

function! s:Command(buffer) abort
  return "%e lint --unstable --json -"
endfunction

function! s:Callback(buffer, lines) abort
  if empty(a:lines)
    return []
  endif

  let l:result = json_decode(join(a:lines, "\n"))
  let l:qflist = deno#lint#ConvertLintResultIntoQflist(l:result)
  call s:FixQflist(a:buffer, l:qflist)
  return l:qflist
endfunction

function! s:FixQflist(buffer, qflist) abort
  for l:item in a:qflist
    let l:item.filename = deno#utils#ResolveFilenameOfBuffer(a:buffer)
  endfor
endfunction

call ale#linter#Define("typescript", {
\ "name": "deno",
\ "executable": function("s:Executable"),
\ "command": function("s:Command"),
\ "callback": function("s:Callback"),
\ "output_stream": "stderr",
\ "read_buffer": 1,
\ "lint_file": 0,
\})
