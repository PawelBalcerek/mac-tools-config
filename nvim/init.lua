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
	-- AI Agent
	{
		"github/copilot.vim",
		event = "BufEnter",
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
	-- LSP
	{ "williamboman/mason.nvim", opts = {} },
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/nvim-cmp",
			"onsails/lspkind.nvim",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"j-hui/fidget.nvim",
		},
		config = function()
			local cmp_lsp = require("cmp_nvim_lsp")
			local capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				cmp_lsp.default_capabilities()
			)
			local lspconfig = require("lspconfig")
			require("fidget").setup({})
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "taplo", "gopls" },
				handlers = {
					function(server_name)
						lspconfig[server_name].setup({
							capabilities = capabilities,
						})
					end,
					["lua_ls"] = function()
						lspconfig.lua_ls.setup({
							capabilities = capabilities,
							settings = {
								Lua = {
									diagnostics = {
										globals = { "vim" },
									},
								},
							},
						})
					end,
				},
			})

			local cmp = require("cmp")
			local luasnip = require("luasnip")

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				formatting = { format = require("lspkind").cmp_format({ mode = "symbol_text" }) },
				mapping = cmp.mapping.preset.insert({
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<C-Space>"] = cmp.mapping.complete(),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
				}),
			})

			vim.diagnostic.config({
				virtual_text = {
					prefix = "●",
				},
				signs = true,
				update_in_insert = false,
				underline = true,
				severity_sort = true,
				float = {
					focusable = true,
					style = "minimal",
					border = "rounded",
					source = "always",
					header = "",
					prefix = "",
				},
			})
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	-- FORMATTING: Conform
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = { go = { "goimports", "gofumpt" }, lua = { "stylua" }, toml = { "taplo" } },
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
				ensure_installed = { "go", "gomod", "gowork", "gosum", "lua", "vim", "vimdoc", "toml" },
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
	-- colorscheme
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
	-- BUFFERS
	{
		"kazhala/close-buffers.nvim",
		config = function()
			require("close_buffers").setup({
				preserve_window_layout = { "all" },
			})
		end,
	},

	-- other
	"vim-test/vim-test",
	"tpope/vim-dispatch",
	"rrethy/vim-illuminate",
})

-- vim-test config
vim.g["test#strategy"] = "dispatch"

-- keymaps
local opts = { silent = true }

-- copilot
vim.keymap.set("n", "<leader>ce", ":let g:copilot_enabled = 1<CR>", { desc = "Enable Copilot" })
vim.keymap.set("n", "<leader>cd", ":let g:copilot_enabled = 0<CR>", { desc = "Disable Copilot" })

-- running
vim.keymap.set("n", "<leader>r", function() end, { desc = "Run" })

-- running tests
vim.keymap.set("n", "<leader>tf", "<cmd>TestFile | wincmd p<CR>", opts, { desc = "Run file tests" })
vim.keymap.set("n", "<leader>tn", "<cmd>TestNearest | wincmd p<CR>", opts, { desc = "Run nearest tests" })

-- formatting
vim.keymap.set("n", "<leader>f", function()
	require("conform").format({ formatters = { "gofumpt" } })
end, { desc = "Format" })
vim.keymap.set("n", "<leader>fa", function()
	require("conform").format({ formatters = { "goimports", "gofumpt" } })
end, { desc = "Format all" })

-- lsp
vim.keymap.set("n", "<C-i>", vim.lsp.buf.hover, { desc = "Information" })
local telescope_builtin = require("telescope.builtin")
vim.keymap.set("n", "<C-S-d>", telescope_builtin.lsp_definitions, { desc = "Look definition" })
vim.keymap.set("n", "<C-S-r>", telescope_builtin.lsp_references, { desc = "Look references" })
vim.keymap.set("n", "<A-CR>", vim.lsp.buf.code_action, { desc = "Code actions" })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })

-- buffers
-- use [b and ]b for previos and next buffer
vim.keymap.set("n", "<leader>cob", ":BDelete other<CR>", { desc = "Close all other buffers" })
vim.keymap.set("n", "<leader>ccb", ":BDelete<CR>", { desc = "Close current buffer" })

-- diagnostics
vim.keymap.set("n", "[e", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]e", vim.diagnostic.goto_next)

-- different
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
vim.keymap.set("n", "<leader>pm", function()
	if vim.opt.cmdheight:get() == 0 then
		-- Restore standard view (Switch back)
		vim.opt.cmdheight = 1
		vim.opt.laststatus = 2 -- Use 3 for global statusline
		vim.opt.showmode = true
		vim.opt.ruler = true
	else
		-- Enable Zen Mode (Hide everything)
		vim.opt.cmdheight = 0
		vim.opt.laststatus = 0
		vim.opt.showmode = false
		vim.opt.ruler = false
	end
end, { desc = "Toggle Zen Mode" })
