-- Leader key configurations
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Indentation settings
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

-- UI settings
vim.opt.relativenumber = true
vim.opt.termguicolors = true

-- Disable built-in file explorer
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Mouse settings
vim.opt.mousemoveevent = true

-- split a new pane vertically using leader =
vim.keymap.set("n", "<leader>=", "<C-w>v", { silent = true })
-- split a new pane horizontally using leader -
vim.keymap.set("n", "<leader>-", "<C-w>s", { silent = true })
