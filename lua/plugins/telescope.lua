return {
	"nvim-telescope/telescope.nvim",
	dependecies = {
		{ "nvim-lua/plenary.nvim" },
	},
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown({}),
		},
	},
	config = function()
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<Tab><Tab>", builtin.buffers, { desc = "See Buffers" })
		vim.keymap.set("n", "<S-f>", builtin.find_files, { desc = "Find Files" })
		vim.keymap.set("n", "<C-f>", builtin.grep_string, { desc = "Fing String" })
		vim.keymap.set("n", "<leader>fd", builtin.lsp_definitions, { desc = "Go to Definition" })
		vim.keymap.set("n", "<leader>fu", builtin.lsp_references, {desc = "Go to Usages"})
		vim.keymap.set("n", "<leader>ft", builtin.lsp_references, { desc = "Go to Type Definition"})
		vim.keymap.set("n", "<leader>dd", builtin.diagnostics, {})
		vim.keymap.set("n", "<leader>gc", builtin.git_commits, {})
		vim.keymap.set("n", "<leader>gs", builtin.git_status, {})
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
	end,
}
