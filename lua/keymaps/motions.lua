local harpoon = require("harpoon")

harpoon:setup()

vim.g.mapleader = " "
local keymap = vim.keymap.set

-- MENU
keymap("n", "<leader><leader>", ":CHADopen<CR>")

-- MOVING THROUGH SCREENS
keymap("n", "<C-l>", "<C-w>l")
keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-j>", "<C-w>j")
keymap("n", "<C-k>", "<C-w>k")

-- TELESCOPE BUFFERS
keymap("n", "<Tab><Tab>", ":Telescope buffers<cr>")

-- TELESCOPE FIND ALL FILES
keymap("n", "<S-f>", ":Telescope find_files<cr>")

-- TELESCOPE FIND WORD IN ALL FILES
keymap("n", "<S-C-f>", ":Telescope live_grep<cr>")

-- TELESCOPE FIND WORD IN ALL FILES
keymap("n", "<C-f>", ":Telescope grep_string<cr>")

-- JUMP TO LATEST BUFFER
keymap("n", "<C-e>", ":b#<cr>")
keymap("i", "<C-e>", "<ESC>:b#<cr>a")

keymap("n", "<leader>a", function() harpoon:list():add() end)
keymap("n", "<C-x>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
