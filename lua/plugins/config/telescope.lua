local builtin = require('telescope.builtin')
local actions = require('telescope.actions')
local tele = require('telescope')



vim.keymap.set('n', '<TAB><TAB>', builtin.buffers, {})
vim.keymap.set('n', '<C-e>', ":b#<CR>", {})

vim.keymap.set('n', '<C-f>', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)
vim.keymap.set('n', '<leader><leader>', builtin.git_files, {})
vim.keymap.set('n', '<C-S-f>', builtin.find_files, {})

vim.keymap.set('n', '<C-t>', builtin.treesitter, {})
vim.keymap.set('n', '<C-g>c', builtin.git_commits, {})
vim.keymap.set('n', '<C-g>s', ":Git<CR>", {})

vim.keymap.set('n', '<C-g>g', function ()
            tele.extensions.git_worktree.git_worktrees()
        end) 

vim.keymap.set('n', '<C-g>w', function ()
            tele.extensions.git_worktree.create_git_worktree()
        end)


require("telescope").load_extension("git_worktree")
