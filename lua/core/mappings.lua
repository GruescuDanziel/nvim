local setKey = vim.keymap.set

setKey("n", "<C-h>", "<C-w>h")
setKey("n", "<C-j>", "<C-w>j")
setKey("n", "<C-k>", "<C-w>k")
setKey("n", "<C-l>", "<C-w>l")
setKey("n", "<ESC>", ":nohl<CR>")
setKey("i", "<ESC>", "<ESC>:w<CR>")


setKey("n", "<C-n>m", ":!nest generate module ")
setKey("n", "<C-n>p", ":!nest generate provider ")
setKey("n", "<C-n>c", ":!nest generate controller ")
setKey("n", "<C-n>s", ":!nest generate service ")
