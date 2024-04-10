--vim.opt.guicursor = ""
--
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.g.user_emmet_leader_key = "<C-Z>"

vim.opt.smartindent = true

-- vim.opt.wrap = false

vim.opt.breakindent = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

-- vim.api.nvim_set_hl(0, 'LineNr', { guibg = NONE})
-- vim.api.nvim_set_hl(0, 'signcolumn', { guibg = NONE })
-- vim.api.nvim_set_hl(0, 'LineNr', { bg = "none" })

-- search settings
vim.opt.ignorecase = true -- ignore case when searching
vim.opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive


-- this is the line the middle of the screen. to indecate that the lines are getting too long
-- vim.opt.colorcolumn = "80"
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
