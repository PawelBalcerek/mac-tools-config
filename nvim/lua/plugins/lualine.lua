return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		options = { theme = "auto", globalstatus = true },
		sections = {
			lualine_x = {
				"filetype",
				function()
					local msg = "No LSP"
					local clients = vim.lsp.get_clients({ bufnr = 0 })
					if next(clients) == nil then
						return msg
					end
					for _, client in ipairs(clients) do
						return client.name
					end
					return msg
				end,
			},
		},
	},
}
