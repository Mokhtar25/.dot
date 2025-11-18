return {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
    config = function()
        require("typescript-tools").setup({
            settings = {
                -- Ensure this is the only TypeScript server
                separate_diagnostic_server = true,
                -- Disable duplicate diagnostics
                tsserver_file_preferences = {
                    includeCompletionsForModuleExports = true,
                    includeCompletionsWithInsertText = true,

                    importModuleSpecifierPreference = "non-relative",
                    importModuleSpecifierEnding = "auto",
                },
                -- Prevent duplicate diagnostics
                tsserver_format_options = {
                    allowIncompleteCompletions = false,
                    allowRenameOfImportPath = false,
                },
            },
            -- Add the same keymaps that your LSP config provides
            on_attach = function(client, bufnr)
                local keymap = vim.keymap
                local keymap_opts = { noremap = true, silent = true, buffer = bufnr }

                -- TypeScript-specific keymaps
                keymap.set({ "n", "v" }, "<leader>ii", "<cmd>TSToolsOrganizeImports<CR>",
                    vim.tbl_extend("force", keymap_opts, { desc = "Organize imports" }))
                keymap.set("n", "<leader>mm", "<cmd>TSToolsAddMissingImports<CR>",
                    vim.tbl_extend("force", keymap_opts, { desc = "Add missing imports" }))
                keymap.set("n", "<leader>rr", "<cmd>TSToolsRemoveUnused<CR>",
                    vim.tbl_extend("force", keymap_opts, { desc = "Remove unused vars" }))

                -- Standard LSP keymaps for TypeScript files
                keymap_opts.desc = "Show LSP references"
                keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", keymap_opts)

                keymap_opts.desc = "Go to declaration"
                keymap.set("n", "gD", vim.lsp.buf.declaration, keymap_opts)

                keymap_opts.desc = "Show LSP definitions"
                keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", keymap_opts)

                keymap_opts.desc = "Show LSP implementations"
                keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", keymap_opts)

                keymap_opts.desc = "Show LSP type definitions"
                keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", keymap_opts)

                keymap_opts.desc = "See available code actions"
                keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, keymap_opts)

                keymap_opts.desc = "Smart rename"
                keymap.set("n", "<leader>rn", vim.lsp.buf.rename, keymap_opts)

                keymap_opts.desc = "Show buffer diagnostics"
                keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", keymap_opts)

                keymap_opts.desc = "Show line diagnostics"
                keymap.set("n", "<leader>d", vim.diagnostic.open_float, keymap_opts)

                keymap_opts.desc = "Go to previous diagnostic"
                keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, keymap_opts)

                keymap_opts.desc = "Go to next diagnostic"
                keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, keymap_opts)

                keymap_opts.desc = "Show documentation for what is under cursor"
                keymap.set("n", "K", vim.lsp.buf.hover, keymap_opts)

                keymap_opts.desc = "Restart LSP"
                keymap.set("n", "<leader>rs", ":LspRestart<CR>", keymap_opts)
            end,
        })
    end,
}
