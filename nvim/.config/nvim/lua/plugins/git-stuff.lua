return {
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup {
        signs = {
          add          = { text = '+' },
          change       = { text = '~' },
          delete       = { text = '_' },
          topdelete    = { text = '‾' },
          changedelete = { text = '~' },
        },
        preview_config = {
          border = 'rounded', -- 👈 Adds border to hunk preview window
        },
      }

      vim.keymap.set("n", "gp", ":Gitsigns preview_hunk<CR>", {})
    end,
  },
  {
    {
      "sindrets/diffview.nvim",
      cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose", "DiffviewToggleFiles" },
      keys = {
        { "<leader>go", "<cmd>DiffviewOpen<CR>",  desc = "Git Diff" },
        { "<leader>gq", "<cmd>DiffviewClose<CR>", desc = "Close Diffview" },
      },
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function()
        require("diffview").setup()

        -- Custom highlights for added/removed lines
        vim.api.nvim_create_autocmd("ColorScheme", {
          pattern = "*",
          callback = function()
            -- Deleted lines (old) in red
            vim.cmd("highlight DiffDelete guibg=#ffdddd guifg=#ff0000")

            -- Added lines (new) in green
            vim.cmd("highlight DiffAdd guibg=#ddffdd guifg=#008000")

            -- (Optional) changed lines in yellow
            vim.cmd("highlight DiffChange guibg=#ffffcc guifg=NONE")
          end,
        })

        -- Run it once right away in case colorscheme is already loaded
        vim.cmd("highlight DiffDelete guibg=#ffdddd guifg=#ff0000")
        vim.cmd("highlight DiffAdd guibg=#ddffdd guifg=#008000")
        vim.cmd("highlight DiffChange guibg=#ffffcc guifg=NONE")
      end,
    }
  }
}
