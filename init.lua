local opts = { noremap = true, silent = true }

-- vscode neovim and neovim common settings
vim.opt.langmenu = 'en_US.UTF-8'
vim.cmd('language message en_US.UTF-8')
vim.api.nvim_set_keymap('i', 'jk', '<ESC>', opts)
vim.opt.clipboard = 'unnamedplus'

if not vim.g.vscode then
    -- only Neovim
    vim.cmd('syntax enable')
    vim.opt.number = true
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.fn.isdirectory(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup()

-- You need to define the plugins and opts for lazy.setup or use directly
-- For example, to use Comment.nvim
require("lazy").setup({
    {
        "numToStr/Comment.nvim",
	lazy = false,
    }
})


