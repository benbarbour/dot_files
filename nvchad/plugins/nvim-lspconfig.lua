return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ -- format & linting
			"jose-elias-alvarez/null-ls.nvim",
			config = require("custom.configs.null-ls"),
		},
	},
	config = function()
		require("plugins.configs.lspconfig") -- default nvchad config
		require("custom.configs.lspconfig")
	end,
}
