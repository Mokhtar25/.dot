return {
  "pmizio/typescript-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  opts = {
  keys= {
     vim.keymap.set({"n", "v"}, "<leader>ii", "<cmd> TSToolsOrganizeImports <CR>", {desc = "TSToolsOrganizeImports"}),
     vim.keymap.set("n" , "<leader>mm", "<cmd> TSToolsAddMissingImports <CR>", {desc = "add missing imports ts"}),
     vim.keymap.set("n" , "<leader>rr", "<cmd> TSToolsRemoveUnused <CR>", {desc = "remove Unused vars ts"}),
  }},

}
