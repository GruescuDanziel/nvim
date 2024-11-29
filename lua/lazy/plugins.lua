local plugins = {
	{
		'Bekaboo/dropbar.nvim',
		dependencies = {
			'nvim-telescope/telescope-fzf-native.nvim',
			build = 'make'
		}
	},
	{
		'freddiehaddad/feline.nvim',
		opts = {}
	},
	{
		"f-person/git-blame.nvim",
		event = "VeryLazy",
		opts = {
			enabled = true,
			message_template = " <summary> • <date> • <author> • <<sha>>",
			date_format = "%m-%d-%Y %H:%M:%S",
			virtual_text_column = 1,  
		}
	},
	{'neovim/nvim-lspconfig'},
	{'hrsh7th/cmp-nvim-lsp'},
	{
		"williamboman/mason.nvim"
	},
	{'hrsh7th/nvim-cmp'},
	{'ms-jpq/chadtree'},
	 {
		 'nvim-telescope/telescope.nvim', tag = '0.1.8',
		 dependencies = { 'nvim-lua/plenary.nvim' }
	 },
	 {
    		"ThePrimeagen/harpoon",
    		branch = "harpoon2",
    		dependencies = { "nvim-lua/plenary.nvim" 
	}
}

}

return plugins
