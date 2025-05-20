return {
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()

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
      config = true,
    }
  }
}
