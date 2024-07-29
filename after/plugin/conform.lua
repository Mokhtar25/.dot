require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		-- Conform will run multiple formatters sequentially
		python = { "isort", "black" },

		html = { "prettier" },
		css = { "prettier" },
		typescript = { "prettier" },
		-- Use a sub-list to run only the first available formatter
		javascript = { "prettier" },
		javascriptreact = { "prettier" },
		typescriptreact = { "prettier" },

		json = { { "prettier" } },
	},
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})
