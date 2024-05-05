local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

vim.opt.langmenu = 'en_US.UTF-8'
vim.cmd('language message en_US.UTF-8')
vim.opt.clipboard = 'unnamedplus'
vim.g.mapleader = ""

map('i', 'jk', '<ESC>', opts)

map('n', '<C-Q>', '<C-V>', opts)
map("n", "<leader>h", "^", opts)
map("n", "<leader>l", "$", opts)
map("v", "<leader>h", "^", opts)
map("v", "<leader>l", "$", opts)

map("n", "+", "<C-a>", opts)
map("n", "-", "<C-x>", opts)

if not vim.g.vscode then
    -- only Neovim
    vim.cmd('syntax enable')
    vim.opt.number = true
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
	{
	    "kylechui/nvim-surround",
	    version = "*", -- Use for stability; omit to use `main` branch for the latest features
	    event = "VeryLazy",
	    config = function()
		    require("nvim-surround").setup()
	    end
    	},
	{
	    "Diogo-ss/42-header.nvim",
	    lazy = false,
	    config = function()
		    local header = require("42header")
		    header.setup({
		            default_map = true, -- default Mapping <F1> in normal mode
		            auto_update = true,  -- update header when saving
		            user = "hwatahik",
		            mail = "hwatahik@student.42tokyo.jp"
		    })
		end
	}
}

require('lazy').setup(plugins, {})
