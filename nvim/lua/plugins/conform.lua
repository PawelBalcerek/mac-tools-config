return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			toml = { "taplo" },
			go = { "goimports", "gofumpt" },
		},
		format_on_save = { timeout_ms = 500, lsp_fallback = true },
	},
	keys = {
		{
			"<leader>f",
			function()
				if vim.bo.filetype == "go" then
					require("conform").format({ formatters = { "gofumpt" } })
				else
					require("conform").format({ lsp_fallback = true })
				end
			end,
			desc = "Format",
		},
		{
			"<leader>fa",
			function()
				require("conform").format({ lsp_fallback = true })
			end,
			desc = "Format all",
		},
	},
}
