-- LSP Configuration (proper after/plugin structure)
local keymap = vim.keymap

-- LSP keybindings via LspAttach autocmd (applies to ALL LSP clients)
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspKeymaps", { clear = true }),
    callback = function(ev)
        local opts = { noremap = true, silent = true, buffer = ev.buf }

        opts.desc = "Show LSP references"
        keymap.set("n", "gR", vim.lsp.buf.references, opts)

        opts.desc = "Go to declaration"
        keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

        opts.desc = "Go to definition"
        keymap.set("n", "gd", vim.lsp.buf.definition, opts)

        opts.desc = "Show LSP implementations"
        keymap.set("n", "gi", vim.lsp.buf.implementation, opts)

        opts.desc = "Show LSP type definitions"
        keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)

        opts.desc = "See available code actions"
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

        opts.desc = "Smart rename"
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

        opts.desc = "Show buffer diagnostics"
        keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

        opts.desc = "Show line diagnostics"
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

        opts.desc = "Go to previous diagnostic"
        keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, opts)

        opts.desc = "Go to next diagnostic"
        keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, opts)

        opts.desc = "Show documentation for what is under cursor"
        keymap.set("n", "K", vim.lsp.buf.hover, opts)

        opts.desc = "Restart LSP"
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
    end,
})

-- Define servers to set up
local servers = {
    -- html = {},
    -- cssls = {},
    tailwindcss = {
        filetypes = { "html", "css", "javascript", "typescript", "javascriptreact", "typescriptreact" },
    },
    -- prismals = {},
    -- graphql = {
    --   filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
    -- },
    -- emmet_ls = {
    --   filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
    -- },
    -- pyright = {},
    -- gopls = {},
    -- eslint = {},
    clangd = {},
    rust_analyzer = {},
    lua_ls = {
        settings = {
            Lua = {
                -- make the language server recognize "vim" global
                diagnostics = {
                    globals = { "vim" },
                },
                workspace = {
                    -- make language server aware of runtime files
                    library = {
                        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                        [vim.fn.stdpath("config") .. "/lua"] = true,
                    },
                },
            },
        },
    },
}

-- Configure diagnostic signs using modern API
vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "✖",
            [vim.diagnostic.severity.WARN] = "⚠︎",
            [vim.diagnostic.severity.HINT] = "󰠠 ",
            [vim.diagnostic.severity.INFO] = "󰋼 ",
        }
    }
})

for server, config in pairs(servers) do
    config.capabilities = require("cmp_nvim_lsp").default_capabilities(config.capabilities or {})
    vim.lsp.config(server, config)
end
