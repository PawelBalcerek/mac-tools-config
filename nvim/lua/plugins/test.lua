return {
	"vim-test/vim-test",
	dependencies = { "tpope/vim-dispatch" },
	keys = {
		{ "<leader>tf", "<cmd>TestFile | wincmd p<CR>", desc = "Run file tests" },
		{ "<leader>tn", "<cmd>TestNearest | wincmd p<CR>", desc = "Run nearest tests" },
	},
}
