-- require('rose-pine').setup({
--     disable_background = true
-- })
--
-- function ColorMy()
--     -- vim.api.nvim_set_hl(0, 'LineNr', { bg= "none"})
--     vim.ap.nvim_set_hl(0, 'signcolumn', { bg= "nonee" })
--     vim.api.nvim_set_hl(0, 'LineNr', { bg = "none" })
--
-- end
-- ColorMy()
-- set colorscheme to nightfly with protected call
-- in case it isn't installed
local status, _ = pcall(vim.cmd, "colorscheme nightfly")
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, 'LineNr', { bg = "none"})
    vim.api.nvim_set_hl(0, 'signcolumn', { bg = "none" })

    if not status then
  print("Colorscheme not found!") -- print error if colorscheme not installed
  return
end

