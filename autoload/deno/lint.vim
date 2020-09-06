"function! deno#lint#build_command() abort
"  return printf(
"  \ "%s lint --unstable --json %s",
"  \ g:deno_executable,
"  \ l:file)
"endfunction

function! deno#lint#convert_lint_result_into_qflist(result) abort
  let l:errors = map(a:result.errors, '{
    \   "filename": v:val.filename,
    \   "lnum": v:val.location.line,
    \   "col": v:val.location.col + 1,
    \   "text": v:val.message,
    \   "code": v:val.code,
    \   "type": "E",
    \ }')
  let l:diagnostics = map(a:result.diagnostics, '{
    \   "filename": v:val.filename,
    \   "lnum": v:val.location.line,
    \   "col": v:val.location.col + 1,
    \   "text": v:val.message,
    \   "code": v:val.code,
    \   "type": "W",
    \ }')
  return extend(l:errors, l:diagnostics)
endfunction
