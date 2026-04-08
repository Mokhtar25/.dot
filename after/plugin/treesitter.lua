-- nvim-treesitter `main` branch API.
-- Setup is no longer a single setup() call: parsers are installed via
-- require('nvim-treesitter').install(), and highlighting/folds/indents are
-- enabled per buffer through a FileType autocmd.

local ok, ts = pcall(require, "nvim-treesitter")
if not ok then
	return
end

ts.install({
	"javascript",
	"typescript",
	"tsx",
	"go",
	"rust",
	"python",
	"html",
	"css",
	"c",
	"lua",
	"vim",
	"vimdoc",
	"query",
	"markdown",
	"markdown_inline",
})

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("user_treesitter", { clear = true }),
	callback = function(args)
		local buf = args.buf
		if not pcall(vim.treesitter.start, buf) then
			return
		end
		-- Treesitter-powered folds and indents (experimental)
		vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
		vim.wo[0][0].foldmethod = "expr"
		vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})
