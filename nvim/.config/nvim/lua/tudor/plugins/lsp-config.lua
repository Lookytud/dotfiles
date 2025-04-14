-- Lazy.nvim plugin setup
return { -- Mason and Mason-LSPConfig
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			auto_install = true,
		},
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("lspconfig").eslint.setup({
				on_attach = function(client, bufnr)
					client.server_capabilities.documentFormattingProvider = true

					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ async = false })
						end,
					})
				end,
				settings = {
					format = { enable = true },
				},
			})

			require("lspconfig").ts_ls.setup({
				on_attach = function(client, bufnr)
					client.server_capabilities.documentFormattingProvider = false

					local opts = { buffer = bufnr }
					vim.keymap.set("n", "H", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts)
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
				end
			})

			require("lspconfig").lua_ls.setup({
				on_attach = function(client, bufnr)
					client.server_capabilities.documentFormattingProvider = true

					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						callback = function()
							vim.cmd("silent! !stylua %")
							vim.lsp.buf.format({ async = false })
						end,
					})
				end,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})
			vim.keymap.set("n", "gh", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, { noremap = true, silent = true })
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
		end
	},
}
