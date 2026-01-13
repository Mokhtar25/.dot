require("main.remap")
require("main.set")


vim.api.nvim_set_hl(0, 'LineNr', { guibg = NONE })

vim.api.nvim_set_hl(0, 'signcolumn', { guibg = NONE })

vim.keymap.set('n', '<leader>h', function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = 'Toggle inlay hints' })
