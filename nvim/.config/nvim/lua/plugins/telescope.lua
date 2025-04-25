return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			"nvim-tree/nvim-web-devicons",
			"folke/todo-comments.nvim",
		},
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")
			local builtin = require("telescope.builtin")

			telescope.setup({
				defaults = {
					mappings = {
						i = {
							["<C-i>"] = actions.move_selection_previous, -- up
							["<C-k>"] = actions.move_selection_next, -- down
							["<C-l>"] = actions.select_default, -- open
							["dd"] = actions.delete_buffer,
						},
						n = {
							["<C-d>"] = actions.delete_buffer,
						},
					},
				},
			})

			-- Keymaps
			vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "Find Files" })
			vim.keymap.set("n", "<C-f>", builtin.current_buffer_fuzzy_find, { desc = "Search in File" })
			vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "Open Buffers" })
			vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
			vim.keymap.set("n", "<leader>r", "<cmd>Telescope oldfiles<CR>")
		end,
	},
}
