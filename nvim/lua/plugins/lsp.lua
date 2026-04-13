return {
	{ "williamboman/mason.nvim", opts = {} },
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
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
		keys = {
			{ "<C-i>", vim.lsp.buf.hover, desc = "Information" },
			{ "<A-CR>", vim.lsp.buf.code_action, desc = "Code actions" },
			{ "[e", vim.diagnostic.goto_prev, desc = "Previous diagnostic" },
			{ "]e", vim.diagnostic.goto_next, desc = "Next diagnostic" },
			{ "<leader>rn", vim.lsp.buf.rename, desc = "Rename" },
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
				ensure_installed = {
					"lua_ls",
					"taplo",
					"marksman",
					"gopls",
					"pyright",
					"ruff",
					"dockerls",
					"docker_compose_language_service",
					"yamlls",
					"bashls",
				},
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
					["pyright"] = function()
						lspconfig.pyright.setup({
							capabilities = capabilities,
							settings = {
								python = {
									analysis = {
										autoSearchPaths = true,
										useLibraryCodeForTypes = true,
										autoImportCompletions = true,
										indexing = true,
									},
								},
							},
						})
					end,
					["ruff"] = function()
						lspconfig.ruff.setup({
							capabilities = capabilities,
							on_attach = function(client, _)
								client.server_capabilities.hoverProvider = false
							end,
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
}
