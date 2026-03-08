return {
	"kazhala/close-buffers.nvim",
	keys = {
		{ "<leader>cob", ":BDelete other<CR>", desc = "Close all other buffers" },
		{ "<leader>ccb", ":bd<CR>", desc = "Close current buffer" },
	},
	config = function()
		require("close_buffers").setup({
			preserve_window_layout = { "all" },
		})
	end,
}
