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

                    includeInlayParameterNameHints = "all",
                    includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                    includeInlayFunctionParameterTypeHints = true,
                    includeInlayVariableTypeHints = true,
                    includeInlayPropertyDeclarationTypeHints = true,
                    includeInlayFunctionLikeReturnTypeHints = true,
                    includeInlayEnumMemberValueHints = true,
                },
                -- Prevent duplicate diagnostics
                tsserver_format_options = {
                    allowIncompleteCompletions = false,
                    allowRenameOfImportPath = false,
                },
            },
            on_attach = function(client, bufnr)
                local keymap = vim.keymap
                local opts = { noremap = true, silent = true, buffer = bufnr }
                vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })

                -- TypeScript-specific keymaps (standard LSP keymaps handled by LspAttach autocmd)
                keymap.set({ "n", "v" }, "<leader>ii", "<cmd>TSToolsOrganizeImports<CR>",
                    vim.tbl_extend("force", opts, { desc = "Organize imports" }))
                keymap.set("n", "<leader>mm", "<cmd>TSToolsAddMissingImports<CR>",
                    vim.tbl_extend("force", opts, { desc = "Add missing imports" }))
                keymap.set("n", "<leader>rr", "<cmd>TSToolsRemoveUnused<CR>",
                    vim.tbl_extend("force", opts, { desc = "Remove unused vars" }))
            end,
        })
    end,
}
