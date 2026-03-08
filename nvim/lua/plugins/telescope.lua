return {
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
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
	},
}

--[[
--
-- How to use find and replace? 
--
-- 1. <D-S-f>
-- 2. Type the search term.
-- 3. Press <C-q> to send the search results to the quickfix list.
-- 4. Run :cdo s/old/new/gc | update to perform the replacement across all files in the quickfix list, with confirmation for each replacement.
--
--]]
