return {
	{
		"mason-org/mason.nvim",
		config = function()
			require("mason").setup(
				{
					ui = {
						icons = {
							package_installed = "✓",
							package_pending = "➜",
							package_uninstalled = "✗",
						},
					},
				}
			)
		end
	},
	{
		"mason-org/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			auto_install = true,
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			{ "antosha417/nvim-lsp-file-operations", config = true },
		},
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			-- import cmp-nvim-lsp plugin
			local cmp_nvim_lsp = require("cmp_nvim_lsp")
			local capabilities = cmp_nvim_lsp.default_capabilities()
			-- local capabilities = require('blink.cmp').get_lsp_capabilities()
			-- Change the Diagnostic symbols in the sign column (gutter)
			local signs = {
				[vim.diagnostic.severity.ERROR] = " ",
				[vim.diagnostic.severity.WARN]  = " ",
				[vim.diagnostic.severity.HINT]  = "󰠠 ",
				[vim.diagnostic.severity.INFO]  = " ",
			}

			-- Apply the icons using the new API
			vim.diagnostic.config({
				signs = {
					text = signs,
				},
				virtual_text = true,
				underline = true,
				update_in_insert = false,
			})
			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
				vim.lsp.handlers.hover,
				{ border = "rounded" }
			)

			require("plugins.lsp.eslint-ls")
			-- require("lspconfig").ts_ls.setup({
			-- 	capabilities = capabilities,
			-- 	on_attach = function(client, bufnr)
			-- 		client.server_capabilities.documentFormattingProvider = false
			-- 		client.server_capabilities.documentRangeFormattingProvider = false
			-- 	end
			-- })

			require("lspconfig").lua_ls.setup({
				capabilities = capabilities,
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

			local keymap = vim.keymap -- for conciseness

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					-- Buffer local mappings.
					-- See `:help vim.lsp.*` for documentation on any of the below functions
					local opts = { buffer = ev.buf, silent = true }

					-- set keybinds

					opts.desc = "Go to declaration"
					keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

					opts.desc = "Show LSP referance"
					keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)

					opts.desc = "Show LSP definitions"
					keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

					opts.desc = "Show LSP implementations"
					keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

					opts.desc = "Show LSP type definitions"
					keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

					opts.desc = "See available code actions"
					keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

					opts.desc = "Smart rename"
					keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

					opts.desc = "Show buffer diagnostics"
					keymap.set("n", "<leader>da", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

					opts.desc = "Show line diagnostics"
					keymap.set("n", "<leader>d", function()
						vim.diagnostic.open_float(nil, { border = "rounded" })
					end, opts)

					opts.desc = "Go to previous diagnostic"
					keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

					opts.desc = "Go to next diagnostic"
					keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

					opts.desc = "Show documentation for what is under cursor"
					keymap.set("n", "gh", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

					vim.keymap.set("n", "<leader>rs", function()
						local bufnr = vim.api.nvim_get_current_buf()
						local clients = vim.lsp.get_clients({ bufnr = bufnr })

						if vim.tbl_isempty(clients) then
							vim.notify("No LSP clients attached to current buffer", vim.log.levels.WARN)
							return
						end

						for _, client in ipairs(clients) do
							vim.notify("Restarting LSP: " .. client.name, vim.log.levels.INFO)
							client.stop(true)
							vim.defer_fn(function()
								require("lspconfig")[client.name].launch()
								vim.notify("Reattached LSP: " .. client.name, vim.log.levels.INFO)
							end, 300)
						end
					end, { desc = "Restart buffer's LSP" })
				end,
			})
			vim.api.nvim_create_autocmd("ColorScheme", {
				callback = function()
					vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { underline = true, sp = "#db302d" })
					vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { underline = true, sp = "#e0af68" })
					vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { underline = true, sp = "#0db9d7" })
					vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { underline = true, sp = "#10b981" })
				end,
			})
		end
	},
}
