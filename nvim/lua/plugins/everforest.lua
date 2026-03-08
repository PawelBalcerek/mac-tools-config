return {
	"sainnhe/everforest",
	lazy = false,
	priority = 1000,
	config = function()
		vim.g.everforest_background = "hard"
		vim.g.everforest_enable_italic = 1

		vim.api.nvim_create_autocmd("ColorScheme", {
			pattern = "everforest",
			callback = function()
				local hl = vim.api.nvim_set_hl

				local black = "#000000"
				local dim_green = "#4b5644"
				local grey_green = "#d3c6aa"

				hl(0, "Normal", { bg = black, fg = grey_green })
				hl(0, "NormalFloat", { bg = black })
				hl(0, "LineNr", { bg = black, fg = dim_green })
				hl(0, "SignColumn", { bg = black })
				hl(0, "EndOfBuffer", { bg = black, fg = black })

				hl(0, "IlluminatedWordText", { underline = true })
				hl(0, "IlluminatedWordRead", { underline = true })
				hl(0, "IlluminatedWordWrite", { underline = true })
			end,
		})

		vim.cmd([[colorscheme everforest]])
	end,
}
