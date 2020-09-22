# vim-deno

An experimental vim plugin for Deno

## Requirements

- Neovim
- Deno
- Node.js (Not required if you don't use [ALE integration](#experimental-ale-integration))

## Features

- [Basic interface for deno command](#commands)
- [ALE integration](#experimental-ale-integration)

## Installation

#### [dein.vim](https://github.com/Shougo/dein.vim)

```toml
[[plugins]]
repo = 'uki00a/vim-deno'
build = 'npm install' # If you want to use tsserver integration via ALE
```

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

## (experimental) ALE integration

This plugin provides [ALE](https://github.com/dense-analysis/ale) integration. The following linters are defined in [ale_linters/typescript](/ale_linters/typescript) directory:

* `deno` - lints the file using `deno lint` command.
* `deno-tsserver` - provides tsserver integration using [typescript-deno-plugin](https://github.com/justjavac/typescript-deno-plugin).

When you want to use `deno-tsserver`, run the following command in the root directory of this plugin:

```shell
$ npm install
```

By default, ALE run all available linters. If you limit ALE to use linters provided by this plugin, add the following setting to your `init.vim`:

```vim
let g:ale_linters = {}

...

let g:ale_linters['typescript'] = ['deno', 'deno-tsserver']
```

## TODO

- [ ] Add support for Vim
- [ ] Implement DenoRun command
- [x] Implement DenoLint command
- [ ] Improve DenoTest command
- [x] ALE integration
- [x] tsserver integration
- [ ] LSP integration?
