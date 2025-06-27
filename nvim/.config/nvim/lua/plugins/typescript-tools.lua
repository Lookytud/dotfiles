return {
    "pmizio/typescript-tools.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "neovim/nvim-lspconfig",
        "hrsh7th/cmp-nvim-lsp",
    },
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    config = function()
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        require("typescript-tools").setup({
            capabilities = capabilities,
            on_attach = function(client, bufnr)
                -- 🔸 Disable formatting from tsserver (use eslint or other tools instead)
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.documentRangeFormattingProvider = false

                local opts = { buffer = bufnr, silent = true }

                -- 🔹 Your keymaps (copied from your earlier config)
            end,

            settings = {
                -- 🔧 Example settings (can be adjusted to your needs)
                expose_as_code_action = "all", -- or { "add_missing_imports", "remove_unused", ... }
                tsserver_file_preferences = {
                    includeInlayParameterNameHints = "all",
                    includeCompletionsForModuleExports = true,
                },
                tsserver_format_options = {
                    allowIncompleteCompletions = false,
                },
            },
        })
    end,
}
