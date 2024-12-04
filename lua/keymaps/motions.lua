local harpoon = require("harpoon")

harpoon:setup()

local keymap = vim.keymap.set

-- MOVING THROUGH SCREENS
keymap("n", "<C-l>", "<C-w>l")
keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-j>", "<C-w>j")
keymap("n", "<C-k>", "<C-w>k")

-- JUMP TO LATEST BUFFER
keymap("n", "<C-e>", ":b#<cr>")
keymap("i", "<C-e>", "<ESC>:b#<cr>a")
