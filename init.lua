-- core setting
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

vim.opt.langmenu = 'en_US.UTF-8'
vim.cmd('language message en_US.UTF-8')
vim.opt.clipboard = 'unnamedplus'

map('i', 'jk', '<ESC>', opts)
map('n', '<C-Q>', '<C-V>', opts)
map("n", "<S-h>", "^", opts)
map("n", "<S-l>", "$", opts)
map("v", "<S-h>", "^", opts)
map("v", "<S-l>", "$", opts)
map("n", "+", "<C-a>", opts)
map("n", "-", "<C-x>", opts)

-- plugins
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


-- vscode only
-- gk, gj etc.. mapping like neovim
-- https://zenn.dev/januswel/articles/bf117ede3f5091
if vim.g.vscode then
  local vscode = require('vscode-neovim')
  local mappings = {
    up = 'k',
    down = 'j',
    wrappedLineStart = '0',
    wrappedLineFirstNonWhitespaceCharacter = '^',
    wrappedLineEnd = '$',
  }

  -- it cannot move like 11j and 103k
  --local function moveCursor(to, select)
  --  return function()
  --    local mode = vim.api.nvim_get_mode()
  --    if mode.mode == 'V' or mode.mode == '' then
  --      return mappings[to]
  --    end

  --    vscode.action('cursorMove', {
  --      args = {
  --        {
  --          to = to,
  --          by = 'wrappedLine',
  --          value = vim.v.count1,
  --          select = select
  --        },
  --      },
  --    })
  --    return '<Ignore>'
  --  end
  --end

  local function moveCursor(to, select)
    return function()
        local count = vim.v.count > 0 and vim.v.count or 1
        local mode = vim.api.nvim_get_mode().mode

        if mode == 'V' or mode == '' then
            for i = 1, count do
                vscode.action('cursorMove', {
                    args = {
                        to = to,
                        by = 'wrappedLine',
                        select = select
                    },
                })
            end
            return '<Ignore>'
        else
            return mappings[to]:rep(count)
        end
	end
  end
  vim.keymap.set('n', 'k', moveCursor('up'), { expr = true })
  vim.keymap.set('n', 'j', moveCursor('down'), { expr = true })
  vim.keymap.set('n', '0', moveCursor('wrappedLineStart'), { expr = true })
  vim.keymap.set('n', '^', moveCursor('wrappedLineFirstNonWhitespaceCharacter'), { expr = true })
  vim.keymap.set('n', '$', moveCursor('wrappedLineEnd'), { expr = true })

  vim.keymap.set('v', 'k', moveCursor('up', true), { expr = true })
  vim.keymap.set('v', 'j', moveCursor('down', true), { expr = true })
  vim.keymap.set('v', '0', moveCursor('wrappedLineStart', true), { expr = true })
  vim.keymap.set('v', '^', moveCursor('wrappedLineFirstNonWhitespaceCharacter', true), { expr = true })
  vim.keymap.set('v', '$', moveCursor('wrappedLineEnd', true), { expr = true })
end


-- neovim only
if not vim.g.vscode then
    -- only Neovim
    vim.cmd('syntax enable')
    vim.opt.number = true
end

