return {
	"ThePrimeagen/refactoring.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	keys = {
		{
			"<leader>ref",
			function()
				require("refactoring").refactor("Extract Function")
			end,
			mode = { "n", "x" },
			desc = "Extract Function",
		},
		{
			"<leader>rev",
			function()
				require("refactoring").refactor("Extract Variable")
			end,
			mode = { "n", "x" },
			desc = "Extract Variable",
		},
		{
			"<leader>riv",
			function()
				require("refactoring").refactor("Inline Variable")
			end,
			mode = { "n", "x" },
			desc = "Inline Variable",
		},
	},
	config = function()
		require("refactoring").setup()
	end,
}
