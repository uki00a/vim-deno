let s:job_info_by_id = {}
function! deno#child_process#Exec(command, ...) abort
  if a:0 > 1
    let l:input = a:1
    let l:Callback = a:2
  else
    let l:input = v:null
    let l:Callback = a:1
  endif

  let l:job_options = {
    \   "on_stdout": function("s:NvimCallback"),
    \   "on_stderr": function("s:NvimCallback"),
    \   "on_exit": function("s:NvimCallback"),
    \ }
  let l:job_id = jobstart(a:command, l:job_options)
  let l:job_info = {
    \   "out": "",
    \   "err": "",
    \   "Callback": l:Callback
    \ }
  let s:job_info_by_id[l:job_id] = l:job_info

  if !empty(l:input)
    call chansend(l:job_id, l:input)
    call chanclose(l:job_id, "stdin")
  endif
endfunction

function! s:NvimCallback(job_id, data, event) abort
  let l:job_info = s:job_info_by_id[a:job_id]
  if a:event == "stdout"
    let l:job_info.out .= join(a:data, "\n")
  elseif a:event == "stderr"
    let l:job_info.err .= join(a:data, "\n")
  else
    call remove(s:job_info_by_id, a:job_id)
    if a:data == 0
      call l:job_info.Callback(v:null, l:job_info.out)
    else
      call l:job_info.Callback(l:job_info.err, v:null)
    endif
  endif
endfunction
