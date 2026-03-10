return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			toml = { "taplo" },
			markdown = { "prettier" },
		},
		formatters = {
			prettier = {
				prepend_args = { "--prose-wrap", "always", "--print-width", "120" },
			},
		},
		format_on_save = { timeout_ms = 500, lsp_fallback = true },
	},
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ lsp_fallback = true })
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
