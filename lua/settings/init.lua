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
