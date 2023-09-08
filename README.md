# add-plugin.nvim

A Neovim plugin to easily create new Lua plugin files.

## Features

- Create a new Lua file with a predefined template at a specified location.
- Open the newly created file in Neovim for editing.
- Customize the root path and content of the template.

## Requirements

- Neovim >= 0.9.0

## Installation

With a plugin manager like [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  "tetzng/add-plugin.nvim",
  ---@type AddPlugin.UserConfig
  opts = {},
}
```

## Usage

In Neovim, use the `:AddPlugin` command followed by the name of lua file for the plugin you want to create:

```vim
:AddPlugin your_plugin_name
```

## Configuration

You can customize the behavior of `add-plugin.nvim` by providing a configuration table during setup. Here's an example:

```lua
require("add_plugin").setup({
  open_on_create = false, -- optional: open the file after creating
  plugin_root_path = 'your_nvim_root/plugins', -- optional: default is inferred from $MYVIMRC
  content = [[
local M = {}
return M
]], -- optional: default template content
})
```
