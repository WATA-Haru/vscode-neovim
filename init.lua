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
