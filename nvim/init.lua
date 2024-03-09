local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')

Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})

vim.call('plug#end')

vim.filetype.add({
  pattern = { [".*/hyprland%.conf"] = "hyprlang" },
})

vim.o.number = true;
vim.o.relativenumber = true;
