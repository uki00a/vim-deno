# vim-deno

An experimental vim plugin for Deno

## Requirements

- Neovim
- Deno

## Commands

Format the current buffer using `deno fmt`:

```
:DenoFmt
```

Run tests for the current file using `deno test`:

```
:DenoTest
```

Lint the current buffer using `deno lint`:

```
:DenoLint
```

Show documentation for the current file using `deno doc`:

```
:DenoDoc
```

## ALE integration

TODO

## TODO

- [ ] Add support for Vim
- [ ] Implement DenoRun command
- [x] Implement DenoLint command
- [ ] Improve DenoTest command
- [ ] ALE integration?
- [ ] LSP or tsserver integration?
  - Start tsserver with [typescript-deno-plugin](https://github.com/justjavac/typescript-deno-plugin) enabled?
