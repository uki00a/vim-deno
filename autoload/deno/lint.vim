function! deno#lint#ConvertLintResultIntoQflist(result) abort
  let l:errors = map(a:result.errors, '{
    \   "filename": v:val.filename,
    \   "lnum": v:val.range.start.line,
    \   "col": v:val.range.start.col + 1,
    \   "text": v:val.message,
    \   "code": v:val.code,
    \   "type": "E",
    \ }')
  let l:diagnostics = map(a:result.diagnostics, '{
    \   "filename": v:val.filename,
    \   "lnum": v:val.range.start.line,
    \   "col": v:val.range.start.col + 1,
    \   "text": v:val.message,
    \   "code": v:val.code,
    \   "type": "W",
    \ }')
  return extend(l:errors, l:diagnostics)
endfunction
