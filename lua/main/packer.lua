-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")
	-- copilot
	use("github/copilot.vim")
	use("lukas-reineke/indent-blankline.nvim")

	-- use({ "nvim-java/nvim-java" })
	use({
		"nvim-java/nvim-java",
		requires = {
			"nvim-java/lua-async-await",
			"nvim-java/nvim-java-core",
			"nvim-java/nvim-java-test",
			"nvim-java/nvim-java-dap",
			"nvim-java/nvim-java-refactor", -- Add this line
			"MunifTanjim/nui.nvim",
			"neovim/nvim-lspconfig",
			"mfussenegger/nvim-dap",
			{
				"williamboman/mason.nvim",
				run = ":MasonUpdate",
			},
		},
	})
	--

	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		-- or                            , branch = '0.1.x',
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	use({
		"rose-pine/neovim",
		as = "rose-pine",
		config = function()
			vim.cmd("colorscheme rose-pine")
		end,
	})
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	})

	use("nvim-treesitter/playground")

	use("ThePrimeagen/harpoon")
	use("mbbill/undotree")
	use("tpope/vim-fugitive")

	use("bluz71/vim-nightfly-colors")

	use({
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	})

	use("christoomey/vim-tmux-navigator") -- tmux & split window navigation
	--- autocomplete
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-buffer") -- source for text in buffer
	use("hrsh7th/cmp-path") -- source for file system paths
	-- snippets
	use({
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		tag = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!:).
		run = "make install_jsregexp",
	})
	use("saadparwaiz1/cmp_luasnip") -- for autocompletion
	use("rafamadriz/friendly-snippets") -- useful snippets
	use("onsails/lspkind.nvim")
	-- comment
	use("numToStr/Comment.nvim")
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons", opt = true },
	})
	use({
		"williamboman/mason.nvim",
	})
	use({
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	})
	use("hrsh7th/cmp-nvim-lsp")
	use("antosha417/nvim-lsp-file-operations")
	use({
		"kylechui/nvim-surround",
		tag = "*", -- Use for stability; omit to use `main` branch for the latest features
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	})

	--formater
	use({
		"stevearc/conform.nvim",
		config = function()
			require("conform").setup()
		end,
	})

	use("mfussenegger/nvim-lint")

	use({
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	})

	use("JoosepAlviste/nvim-ts-context-commentstring")
	use({
		"barrett-ruth/import-cost.nvim",
		build = "sh install.sh npm",
		-- if on windows
		-- build = 'pwsh install.ps1 yarn',
		config = true,
	})

	-- 	use({ "dsznajder/vscode-es7-javascript-react-snippets", run = "yarn install --frozen-lockfile && yarn compile" })
end)
