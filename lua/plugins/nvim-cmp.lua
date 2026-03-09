return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
        "saadparwaiz1/cmp_luasnip",
        "rafamadriz/friendly-snippets",
        {

            "L3MON4D3/LuaSnip",
            keys = {
                { "<tab>",   false, mode = { "i", "s" } },
                { "<s-tab>", false, mode = { "i", "s" } },
            },
        }
    },
    keys = {
        { "<tab>",   false, mode = { "i", "s" } },
        { "<s-tab>", false, mode = { "i", "s" } },
        { "<C-y>",   false, mode = "i" },
        { "<C-Y>",   false, mode = "i" },
    },
    config = function()
        require("luasnip/loaders/from_vscode").lazy_load()
        local luasnip = require("luasnip")
        local cmp = require("cmp")
        local cmp_lsp = require("cmp_nvim_lsp")

        require("fidget").setup({})

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities()
        )
        vim.g.cmp_capabilities = capabilities
        cmp.setup({
            completion = {
                completeopt = "menu,menuone,preview,noselect",
            },
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-k>"] = cmp.mapping.select_prev_item(cmp_select), -- previous suggestion
                ["<C-j>"] = cmp.mapping.select_next_item(cmp_select), -- next suggestion
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete({ select = true }), -- show completion suggestions
                ["<C-c>"] = cmp.mapping.abort(),                         -- close completion window
                ["<CR>"] = cmp.mapping.confirm({ select = false }),
            }),
            -- sources for autocompletn
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip",          max_item_count = 2 },
                { name = 'codeium',          max_item_count = 2 },
                { name = "buffer", },
                { name = "friendly-snippets" },
                { name = "path" },
            }),
        })
    end




}
