return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    config = function()
        -- Set up NeoTree with default position on the left (for <leader>e)
        require("neo-tree").setup({
            position = "left", -- Default position is 'left'
            filesystem = {
                window = {
                    mappings = {
                        -- Rebind `i` to go up instead of opening info
                        ["i"] = "move_cursor_up", -- This remaps `i` to move up in the NeoTree
                    },
                },
                filtered_items = {
                    visible = true,
                    show_hidden_count = true,
                    hide_dotfiles = false,
                    hide_gitignored = true,
                    hide_by_name = {
                        ".git",
                        ".DS_Store",
                        "thumbs.db",
                    },
                    never_show = {},
                },
            },
        })

        -- Open NeoTree on the left side with <leader>e
        vim.keymap.set("n", "<leader>e", ":Neotree toggle left<CR>", { noremap = true, silent = true })

        -- Open NeoTree in floating mode with <leader>w
        vim.keymap.set("n", "<leader>w", ":Neotree reveal float<CR>", { noremap = true, silent = true })
    end,
}
