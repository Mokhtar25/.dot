require("main.remap")
require("main.set")

-- Disable unused language providers to silence :checkhealth warnings
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_node_provider = 0


vim.api.nvim_set_hl(0, 'LineNr', { guibg = NONE })

vim.api.nvim_set_hl(0, 'signcolumn', { guibg = NONE })

vim.keymap.set('n', '<leader>h', function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = 'Toggle inlay hints' })
