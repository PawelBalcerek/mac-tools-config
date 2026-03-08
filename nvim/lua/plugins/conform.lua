return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = { lua = { "stylua" }, toml = { "taplo" } },
		format_on_save = { timeout_ms = 500, lsp_fallback = true },
	},
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ formatters_by_ft = { lua = { "stylua" }, toml = { "taplo" } } })
			end,
			desc = "Format",
		},
		{
			"<leader>fa",
			function()
				require("conform").format({
					formatters_by_ft = { lua = { "stylua" }, toml = { "taplo" } },
				})
			end,
			desc = "Format all",
		},
	},
}
