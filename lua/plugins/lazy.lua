require("lazy").setup({
	{
		'nvim-telescope/telescope.nvim', tag = '0.1.6',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},
    {'williamboman/mason.nvim'},
    {'williamboman/mason-lspconfig.nvim'},
    {'neovim/nvim-lspconfig'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'hrsh7th/nvim-cmp'},
    {'L3MON4D3/LuaSnip'},
    {'nvim-tree/nvim-tree.lua',
        dependencies = {'nvim-tree/nvim-web-devicons'}
    },
    {'nvim-treesitter/nvim-treesitter'},
    {'navarasu/onedark.nvim'},
    {'maxmx03/solarized.nvim'},
    {'tpope/vim-fugitive'},
    {'ThePrimeagen/git-worktree.nvim'},
    {'startup-nvim/startup.nvim'},
    {'f-person/git-blame.nvim'},
    {'folke/zen-mode.nvim'},
    {'VonHeikemen/fine-cmdline.nvim',
        dependencies = {{'MunifTanjim/nui.nvim'}}
    },
    {'jose-elias-alvarez/null-ls.nvim'},
    {'MunifTanjim/prettier.nvim'},
    {'mfussenegger/nvim-dap'}


})

vim.o.background = 'dark'

require('solarized').setup({
    transparent = true, -- enable transparent background
    palette = 'solarized', -- or selenized
    styles = {
      comments = {},
      functions = {},
      variables = {},
      numbers = {},
      constants = {},
      parameters = {},
      keywords = {},
      types = {},
    },
    enables = {
      bufferline = true,
      cmp = true,
      diagnostic = true,
      dashboard = true,
      editor = true,
      gitsign = true,
      hop = true,
      indentblankline = true,
      lsp = true,
      lspsaga = true,
      navic = true,
      neogit = true,
      neotree = true,
      notify = true,
      noice = true,
      semantic = true,
      syntax = true,
      telescope = true,
      tree = true,
      treesitter = true,
      todo = true,
      whichkey = true,
      mini = true,
    },
    highlights = {},
    colors = {},
    theme = 'neo', -- or 'neo'
    autocmd = true,
})

vim.cmd.colorscheme = 'solarized'
