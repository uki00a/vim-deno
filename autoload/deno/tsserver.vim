function! deno#tsserver#Executable() abort
  return deno#utils#ResolveFromRootDir("/node_modules/.bin/tsserver")
endfunction

function! deno#tsserver#Args() abort
  return printf(
    \   "--globalPlugins typescript-deno-plugin --pluginProbeLocations %s",
    \ deno#utils#ResolveFromRootDir("/node_modules"))
endfunction
