return {
    "tpope/vim-fugitive",
    cmd = { "G", "Gdiffsplit", "Git" },
    keys = {
        { "<leader>gd", ":Gsplit! diff HEAD<CR>", desc = "Git stacked diff (GitLab-style)" },
        { "<leader>gs", ":G<CR>",                 desc = "Git status (Fugitive)" },
    },
    init = function()
        -- Configure diff appearance for stacked layout
        vim.opt.diffopt:append({
            "vertical",  -- Use vertical splits
            "filler",    -- Show filler lines
            "context:4", -- Show 4 lines of context
            "internal",  -- Use Neovim's internal diff engine
            "iblank"     -- Highlight blank line changes
        })
    end
}
