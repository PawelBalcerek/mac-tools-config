return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.config").setup({
			ensure_installed = {
				"lua",
				"vim",
				"vimdoc",
				"toml",
				"markdown",
				"markdown_inline",
				"go",
				"gomod",
				"gowork",
				"gosum",
				"python",
			},
			sync_install = false,
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = { enable = true },
		})
	end,
}
