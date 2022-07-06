# nvim-uncrustify

A simple wrapper for running uncrustify from neovim, written in Lua.

### Install

Install with your packet manager of choice

vim-plug:
```vim
Plug 'metmo/nvim-uncrustify'
```

packer:
```vim
use 'metmo/nvim-uncrustify'
```

### Usage

The default mapping is `<Space>`+`U`, or you can run the formatter with `:Uncrustify`.

The Uncrustify binary, keymapping and path to config file can be changed on setup:

```lua
require('nvim-uncrustify').setup({
        uncrustify_executable = "uncrustify",
        config_path = "/path/to/uncrustify.cfg",
        mapping = "<Space>Y"
    })
```
