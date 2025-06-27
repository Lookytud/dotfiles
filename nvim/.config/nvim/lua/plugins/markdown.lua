return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "markdown" },
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "MunifTanjim/nui.nvim",
        },
        config = function()
            require("render-markdown").setup({
                -- Enable conceal (hide #, *, etc)
                conceal = true,

                -- Enable decorations (checkboxes, tables, etc)
                decorations = true,

                -- Syntax tree highlighting (requires markdown treesitter)
                syntax_highlighting = true,

                -- Auto refresh on buffer change
                refresh_on_change = true,

                -- Virtual text for task lists, emojis, etc
                virtual_text = true,
            })

            -- Optional: keymap to toggle render-markdown buffer on/off
            vim.keymap.set("n", "<leader>rm", function()
                if require("render-markdown").is_enabled() then
                    require("render-markdown").disable()
                else
                    require("render-markdown").enable()
                end
            end, { desc = "Toggle Render Markdown" })

            -- Conceal options for nicer appearance
            vim.opt.conceallevel = 2
            vim.opt.concealcursor = "nc"
        end,
    },
}
