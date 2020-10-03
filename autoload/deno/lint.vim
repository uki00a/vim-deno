function! deno#lint#Command(args) abort
  return deno#config#Command("lint", a:args)
endfunction

function! deno#lint#LintBuffer(buf) abort
  let l:cmd = deno#lint#Command(["--unstable", "--json", "-"])
  let l:contents = deno#utils#GetContentsOfBuffer(a:buf)
  call deno#child_process#Exec(l:cmd, l:contents, function("s:LintCallback"))
endfunction

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

function! s:LintCallback(err, _out) abort
  if a:err == v:null
    return
  endif
  let l:lint_result = json_decode(a:err)
  let l:qflist = deno#lint#ConvertLintResultIntoQflist(l:lint_result)
  call setqflist(l:qflist, " ")
  copen
endfunction
