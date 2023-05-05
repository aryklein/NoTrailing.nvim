# NoTrailing.nvim

A simple Neovim plugin to highlight and remove trailing whitespace.

> **_NOTE:_** This is just a PoC on creating a Lua Neovim plugin.
You may consider to use `autocmd BufWritePre * :%s/\s\+$//e` instead.

## Installation

```lua
-- using Lazy

{
    'aryklein/NoTrailing.nvim'
    cmd = {"TrailingTrim", "TrailingHighlightToggle"},
    config = function ()
        require('NoTrailing').setup({
            -- configuration options and defaults

            -- `highlight` configures which highlight is used to display the trailing whitespaces
            highlight = "Search",

            -- `exclude_filetypes` configures which filetypes to exclude when displaying trailing whitespaces
            exclude_filetypes = {"Telescope", "help", "lazy", "packer", "dashboard", "NvimTree", "Trouble"},
        })
    end
}
```
