	local base_on_attach = vim.lsp.config.eslint.on_attach
  vim.lsp.config("eslint", {
    on_attach = function(client, bufnr)
      if not base_on_attach then return end

      base_on_attach(client, bufnr)
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        command = "LspEslintFixAll",
      })
    end,
  })		
-- require("lspconfig").eslint.setup({
--
-- 				capabilities = capabilities,
-- 				on_attach = function(client, bufnr)
-- 					-- Optional: Disable other formatters if you have multiple LSPs
-- 					client.server_capabilities.documentFormattingProvider = true
--
-- 					vim.api.nvim_create_autocmd("BufWritePre", {
-- 						buffer = bufnr,
-- 						callback = function()
-- 							-- Format only with ESLint if it's available and attached
-- 							vim.lsp.buf.format({
-- 								async = true,
-- 								filter = function(format_client)
-- 									return format_client.name == "eslint"
-- 								end,
-- 							})
-- 						end,
-- 					})
-- 				end,
-- 				settings = {
-- 					format = { enable = true },
-- 				},
-- 			})
