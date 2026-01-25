vim.opt.number = true
vim.opt.compatible = false

-- Plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- AI Engine
	{
		"Exafunction/codeium.vim",
		event = "BufEnter",
	},
	-- IntelliSense
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"onsails/lspkind.nvim",
		},
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				formatting = { format = require("lspkind").cmp_format({ mode = "symbol_text" }) },
				mapping = cmp.mapping.preset.insert({
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping.select_next_item(),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "buffer" },
				}),
			})
		end,
	},
	--  UI: Lualine & Icons
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = { theme = "auto", globalstatus = true },
			sections = {
				lualine_x = {
					"filetype",
					function()
						local msg = "No LSP"
						local clients = vim.lsp.get_clients({ bufnr = 0 })
						if next(clients) == nil then
							return msg
						end
						for _, client in ipairs(clients) do
							return client.name
						end
						return msg
					end,
				},
			},
		},
	},
	-- LSP & TOOLS: Mason & Lspconfig & Telescope
	{ "williamboman/mason.nvim", opts = {} },
	{
		"neovim/nvim-lspconfig",
		dependencies = { "williamboman/mason-lspconfig.nvim" },
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	-- FORMATTING: Conform
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = { python = { "isort", "black" }, lua = { "stylua" } },
			format_on_save = { timeout_ms = 500, lsp_fallback = true },
		},
	},
	-- SYNTAX: Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local config = require("nvim-treesitter.config")

			config.setup({
				ensure_installed = { "lua", "python" },
				sync_install = false,
				auto_install = true,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				indent = { enable = true },
			})
		end,
	},
	-- COLORSCHEME
	{
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
	},

	-- OTHERS
	"vim-test/vim-test",
	"tpope/vim-dispatch",
	"rrethy/vim-illuminate",
})

-- Enable Python LSP
vim.lsp.enable("pyright")
vim.lsp.enable("lua_ls")

-- Keymaps
local opts = { silent = true }

-- Codeium
vim.keymap.set("n", "<leader>ce", ":Codeium Enable<CR>", { desc = "Enable Codeium" })
vim.keymap.set("n", "<leader>cd", ":Codeium Disable<CR>", { desc = "Disable Codeium" })

-- Vim-Test Mappings (From your original config)
vim.keymap.set("n", "<leader>tn", "<cmd>TestNearest | wincmd p<CR>", opts)
vim.keymap.set("n", "<leader>tf", "<cmd>TestFile | wincmd p<CR>", opts)
vim.g["test#strategy"] = "dispatch"

-- Formatting manual trigger
vim.keymap.set("n", "<leader>f", function()
	require("conform").format()
end, { desc = "Format Buffer" })

-- LSP
vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover, { desc = "LSP Hover" })
local telescope_builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ld", telescope_builtin.lsp_definitions, { desc = "Look definition" })
vim.keymap.set("n", "<leader>lr", telescope_builtin.lsp_references, { desc = "Look references" })

-- Dispatch
-- Execute python3 file with dispatch and focus on the new window
vim.keymap.set("n", "<leader>dp", function()
	vim.cmd("Dispatch python3 %")
	vim.cmd("wincmd p")
end, { desc = "Execute Python" })
