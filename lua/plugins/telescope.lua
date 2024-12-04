return {'nvim-telescope/telescope.nvim',
dependecies = {
	{ 'nvim-lua/plenary.nvim'},
},
 extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        -- even more opts
      }

      -- pseudo code / specification for writing custom displays, like the one
      -- for "codeactions"
      -- specific_opts = {
      --   [kind] = {
      --     make_indexed = function(items) -> indexed_items, width,
      --     make_displayer = function(widths) -> displayer
      --     make_display = function(displayer) -> function(e)
      --     make_ordinal = function(e) -> string
      --   },
      --   -- for example to disable the custom builtin "codeactions" display
      --      do the following
      --   codeactions = false,
      -- }
    }
  },
    config = function ()
        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<Tab><Tab>", builtin.buffers, {})
        vim.keymap.set("n", "<S-f>", builtin.find_files, {})
        vim.keymap.set("n", "<S-C-f>", builtin.live_grep, {})
        vim.keymap.set("n", "<C-f>", builtin.grep_string, {})
        vim.keymap.set("n", "ff", builtin.lsp_implementations, {})
        vim.keymap.set("n", "<leader>bs", builtin.lsp_document_symbols, {})
        vim.keymap.set("n", "gt", builtin.lsp_references, {})
        vim.keymap.set("n", "<leader>dd", builtin.diagnostics, {})
        vim.keymap.set("n", "<leader>gc", builtin.git_commits, {})
        vim.keymap.set("n", "<leader>gs", builtin.git_status, {})
    end

}
