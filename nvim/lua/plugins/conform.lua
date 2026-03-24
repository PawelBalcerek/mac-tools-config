return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			toml = { "taplo" },
			go = { "goimports", "gofumpt", "golines" },
			python = { "ruff_organize_imports", "ruff_format" },
			markdown = { "prettier" },
		},
		formatters = {
			prettier = {
				prepend_args = { "--prose-wrap", "always", "--print-width", "120" },
			},
			golines = {
				prepend_args = { "--max-len=120", "--base-formatter=gofumpt" },
			},
		},
		format_on_save = { timeout_ms = 500, lsp_fallback = true },
	},
	keys = {
		{
			"<leader>f",
			function()
				local ft = vim.bo.filetype
				if ft == "go" then
					require("conform").format({ formatters = { "gofumpt", "golines" } })
				elseif ft == "python" then
					require("conform").format({ formatters = { "ruff_format" } })
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
