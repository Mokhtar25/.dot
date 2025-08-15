return {
    'saghen/blink.cmp',
    dependencies = {
        'L3MON4D3/LuaSnip',
        'rafamadriz/friendly-snippets',
        'Exafunction/codeium.nvim',
    },
    version = '*',
    opts = {
        sources = {

            default = { 'lsp', 'path', 'snippets', 'buffer', 'codeium' },
            providers = {
                codeium = { name = 'Codeium', module = 'codeium.blink', async = true },
            },
            priority = { 'lsp', 'path', "codeium", 'buffer' }
        },
        fuzzy = { implementation = "prefer_rust_with_warning" },
        keymap = {
            preset = 'default',
            ['<C-k>'] = { 'select_prev', 'fallback' },
            ['<C-j>'] = { 'select_next', 'fallback' },
            ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
            ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
            ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
            ['<C-c>'] = { 'hide', 'fallback' },
            ['<CR>'] = { 'accept', 'fallback' },
        },
    },

    appearance = {
        -- Sets the fallback highlight groups to nvim-cmp's highlight groups
        -- Useful for when your theme doesn't support blink.cmp
        -- use_nvim_cmp_as_default = true,
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing and ensures icons are aligned
        nerd_font_variant = 'mono'
    },

    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    completion = {
        -- 'prefix' will fuzzy match on the text before the cursor
        -- 'full' will fuzzy match on the text before and after the cursor
        -- keyword = { range = 'prefix' },

        menu = {
            auto_show = true,
            background = '#000',
            border = "single",
            -- nvim-cmp style menu
            draw = {
                columns = {
                    { "label",     "label_description", gap = 1 },
                    { "kind_icon", "kind",              gap = 1 },
                }
            },
        },

        -- Auto brackets
        -- accept = { auto_brackets = { enabled = true } },

        -- Show documentation when selecting a completion item
        documentation = { auto_show = false },

        -- Display a preview of the selected item on the current line
        -- ghost_text = { enabled = false },
    },

    -- Experimental signature help support
    -- signature = { enabled = false },

    -- snippets = {
    --   expand = function(snippet)
    --     require('luasnip').lsp_expand(snippet)
    --   end,
    --   active = function(filter)
    --     if filter and filter.direction then
    --       return require('luasnip').jumpable(filter.direction)
    --     end
    --     return require('luasnip').in_snippet()
    --   end,
    --   jump = function(direction)
    --     require('luasnip').jump(direction)
    --   end,
    -- },

    --   providers = {
    --     lsp = {
    --       name = 'LSP',
    --       module = 'blink.cmp.sources.lsp',
    --     },
    --     path = {
    --       name = 'Path',
    --       module = 'blink.cmp.sources.path',
    --       score_offset = 3,
    --     },
    --     snippets = {
    --       name = 'Snippets',
    --       module = 'blink.cmp.sources.snippets',
    --       score_offset = -3,
    --     },
    --     buffer = {
    --       name = 'Buffer',
    --       module = 'blink.cmp.sources.buffer',
    --       fallbacks = { 'lsp' },
    --     },
    --   },
    -- },
    config =
        function(_, opts)
            local original = require("blink.cmp.completion.list").show
            ---@diagnostic disable-next-line: duplicate-set-field
            require("blink.cmp.completion.list").show = function(ctx, items_by_source)
                local seen = {}
                local function filter(item)
                    if seen[item.label] then return false end
                    seen[item.label] = true
                    return true
                end
                for id in vim.iter(opts.sources.priority) do
                    items_by_source[id] = items_by_source[id] and vim.iter(items_by_source[id]):filter(filter):totable()
                end
                return original(ctx, items_by_source)
            end
            require("blink.cmp").setup(opts)
        end
}
