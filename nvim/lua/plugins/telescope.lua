return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-pack/nvim-spectre",
			opts = {
				open_cmd = function()
					local width = math.floor(vim.o.columns * 0.6)
					local height = math.floor(vim.o.lines * 0.6)
					local col = math.floor((vim.o.columns - width) / 2)
					local row = math.floor((vim.o.lines - height) / 2)

					local buf = vim.api.nvim_create_buf(false, true)
					vim.api.nvim_open_win(buf, true, {
						relative = "editor",
						width = width,
						height = height,
						col = col,
						row = row,
						style = "minimal",
						border = "rounded",
					})
				end,
			},
		},
	},
	keys = {
		{
			"<C-S-d>",
			function()
				require("telescope.builtin").lsp_definitions()
			end,
			desc = "Look definition",
		},
		{
			"<C-S-r>",
			function()
				require("telescope.builtin").lsp_references()
			end,
			desc = "Look references",
		},
		{
			"<D-S-f>",
			function()
				require("telescope.builtin").live_grep()
			end,
			desc = "Find in files",
		},
		{
			"<D-S-r>",
			function()
				require("spectre").toggle()
			end,
			desc = "Find and replace",
		},
		{
			"<D-S-r>",
			function()
				require("spectre").open_visual()
			end,
			mode = "v",
			desc = "Find and replace",
		},
	},
}
