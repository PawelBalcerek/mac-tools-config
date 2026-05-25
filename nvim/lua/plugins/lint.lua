return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			sql = { "sqlfluff" },
		}

		local lint_group = vim.api.nvim_create_augroup("LintOnSave", { clear = true })
		vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter" }, {
			group = lint_group,
			callback = function()
				if lint.linters_by_ft[vim.bo.filetype] then
					lint.try_lint()
				end
			end,
		})
	end,
}
