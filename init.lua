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

--require("lazy").setup({
--  "folke/which-key.nvim",
--  { "folke/neoconf.nvim", cmd = "Neoconf" },
--  "folke/neodev.nvim",
--})

require("lazy").setup("plugins")
--    {
--	"numToStr/Comment.nvim",
--	lazy = false,
--    },
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
})
