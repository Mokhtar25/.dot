return {
    -- Lazy.nvim can manage itself
    { "folke/lazy.nvim" },
    
    -- Copilot
    { "github/copilot.vim" },

    -- Indent guides
    { "lukas-reineke/indent-blankline.nvim" },

    -- Java plugins
    {
        "nvim-java/nvim-java",
        dependencies = {
            "nvim-java/lua-async-await",
            "nvim-java/nvim-java-core",
            "nvim-java/nvim-java-test",
            "nvim-java/nvim-java-dap",
            "nvim-java/nvim-java-refactor",
            "MunifTanjim/nui.nvim",
            "neovim/nvim-lspconfig",
            "mfussenegger/nvim-dap",
            { "williamboman/mason.nvim", build = ":MasonUpdate" },
        },
    },

    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        version = "0.1.5",
        dependencies = { "nvim-lua/plenary.nvim" },
    },

    -- Colorscheme: Rose Pine
    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            vim.cmd("colorscheme rose-pine")
        end,
    },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
    },
    { "nvim-treesitter/playground" },

    -- Miscellaneous plugins
    { "ThePrimeagen/harpoon" },
    { "mbbill/undotree" },
    { "tpope/vim-fugitive" },
    { "bluz71/vim-nightfly-colors" },

    -- Autopairs
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup({})
        end,
    },

    -- Tmux navigator
    { "christoomey/vim-tmux-navigator" },

    -- Autocomplete
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },

    -- Snippets
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
    },
    { "saadparwaiz1/cmp_luasnip" },
    { "rafamadriz/friendly-snippets" },
    { "onsails/lspkind.nvim" },

    -- Comments
    { "numToStr/Comment.nvim" },

    -- Statusline
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons", lazy = true },
    },

    -- Mason and LSP configuration
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    { "neovim/nvim-lspconfig" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "antosha417/nvim-lsp-file-operations" },

    -- Surround text
    {
        "kylechui/nvim-surround",
        version = "*",
        config = function()
            require("nvim-surround").setup({})
        end,
    },

    -- Formatting
    {
        "stevearc/conform.nvim",
        config = function()
            require("conform").setup()
        end,
    },

    -- Linting
    { "mfussenegger/nvim-lint" },

    -- Trouble plugin for diagnostics
    {
        "folke/trouble.nvim",
        dependencies = "kyazdani42/nvim-web-devicons",
        config = function()
            require("trouble").setup({})
        end,
    },

    -- Context-aware comment string
    { "JoosepAlviste/nvim-ts-context-commentstring" },

    {
      "vhyrro/luarocks.nvim",
      priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
      config = true,
  }
}

