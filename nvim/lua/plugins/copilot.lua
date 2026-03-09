return {
	"github/copilot.vim",
	event = "BufEnter",
	keys = {
		{ "<leader>ce", ":let g:copilot_enabled = 1<CR>", desc = "Enable Copilot" },
		{ "<leader>cd", ":let g:copilot_enabled = 0<CR>", desc = "Disable Copilot" },
	},
}
