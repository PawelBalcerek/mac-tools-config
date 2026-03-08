-- General Keymaps (not tied to specific plugins)
-- running
vim.keymap.set("n", "<leader>r", function() end, { desc = "Run" })

-- viewport
vim.keymap.set("n", "<C-j>", "<C-d>", { desc = "Move the cursor down half a screen" })
vim.keymap.set("n", "<C-k>", "<C-u>", { desc = "Move the cursor up half a screen" })
vim.keymap.set("n", "<D-j>", "<C-e>", { desc = "Move the viewport down one line" })
vim.keymap.set("n", "<D-k>", "<C-y>", { desc = "Move the viewport up one line" })
vim.keymap.set("n", "zj", "zb", { desc = "Move the current line to the bottom of the screen" })
vim.keymap.set("n", "zk", "zt", { desc = "Move the current line to the top of the screen" })

-- comment
vim.keymap.set("v", "<D-/>", "gc", { remap = true, desc = "Comment selected lines" })
vim.keymap.set("n", "<D-/>", "gcc", { remap = true, desc = "Comment current line" })

-- floating window management & highlights
vim.keymap.set("n", "<Esc>", function()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local config = vim.api.nvim_win_get_config(win)
		if config.relative ~= "" then
			vim.api.nvim_win_close(win, false)
		end
	end
	vim.cmd("noh")
	return "<Esc>"
end, { desc = "Close floating windows and clear highlights" })

-- Zen Mode toggle
vim.keymap.set("n", "<leader>pm", function()
	if vim.opt.cmdheight:get() == 0 then
		-- Restore standard view
		vim.opt.cmdheight = 1
		vim.opt.laststatus = 2
		vim.opt.showmode = true
		vim.opt.ruler = true
	else
		-- Enable Zen Mode
		vim.opt.cmdheight = 0
		vim.opt.laststatus = 0
		vim.opt.showmode = false
		vim.opt.ruler = false
	end
end, { desc = "Toggle Zen Mode" })
