vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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
require("lazy").setup("plugins")

vim.o.termguicolors = true

vim.cmd [[
set cursorline
hi CursorLine gui=underline cterm=underline
]]

local orig = vim.lsp.handlers["client/registerCapability"]
vim.lsp.handlers["client/registerCapability"] = function(err, res, ctx)
    if type(res) ~= "table" or type(res.registrations) ~= "table" then
        return
    end
    return orig(err, res, ctx)
end

require("personal-plugins.plugins.jest-file-runner")
local jest_picker = require("personal-plugins.plugins.jest-picker")

vim.keymap.set('n', '<leader>R', function() 
  require('personal-plugins.plugins.project_cli').pick_and_run() 
end, { desc = "Run Project CLI Script" })

vim.keymap.set("n", "<F9>", jest_picker.pick_and_run_test, { desc = "Pick and run Jest test" })

vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<M-CR>", ":lua vim.lsp.buf.code_action()<CR>")
vim.keymap.set("n", "<C-s>", ":w<CR>")

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"
vim.o.guicursor = table.concat({
    "n-v-c:block",  -- Normal, Visual, Command: block cursor
    "i-ci:ver25",   -- Insert, Insert Command: vertical bar (line)
    "r-cr:hor20",   -- Replace: horizontal underscore
    "o:hor50",      -- Operator-pending: horizontal
    "a:blinkon100", -- All modes: blinking cursor (optional)
}, ",")
