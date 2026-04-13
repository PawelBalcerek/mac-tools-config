local last_search = ""

local function live_grep_with_memory(opts)
	opts = opts or {}
	local default_text = opts.default_text or last_search

	require("telescope.builtin").live_grep({
		default_text = default_text,
		attach_mappings = function(prompt_bufnr, map)
			local action_state = require("telescope.actions.state")
			local actions = require("telescope.actions")

			map({ "i", "n" }, "<CR>", function()
				last_search = action_state.get_current_line()
				actions.select_default(prompt_bufnr)
			end)

			vim.api.nvim_buf_attach(prompt_bufnr, false, {
				on_lines = function()
					vim.schedule(function()
						if vim.api.nvim_buf_is_valid(prompt_bufnr) then
							last_search = action_state.get_current_line()
						end
					end)
				end,
			})

			return true
		end,
	})
end

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
						zindex = 40,
					})
				end,
			},
		},
	},
	opts = {
		defaults = {
			initial_mode = "normal",
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
				live_grep_with_memory()
			end,
			desc = "Find in files",
		},
		{
			"<D-S-f>",
			function()
				local old_reg = vim.fn.getreg("v")
				vim.cmd('normal! "vy')
				local selection = vim.fn.getreg("v")
				vim.fn.setreg("v", old_reg)
				last_search = selection
				live_grep_with_memory({ default_text = selection })
			end,
			mode = "v",
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
