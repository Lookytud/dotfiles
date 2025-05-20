return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			"nvim-tree/nvim-web-devicons",
			"folke/todo-comments.nvim",
			"andrew-george/telescope-themes",
		},
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")
			local builtin = require("telescope.builtin")

			telescope.load_extension("fzf")
			telescope.load_extension("themes")

			telescope.setup({
				defaults = {
					mappings = {
						i = {
							["<C-i>"] = actions.move_selection_previous, -- up
							["<C-k>"] = actions.move_selection_next, -- down
							["<C-l>"] = actions.select_default, -- open
							["<C-d>"] = actions.delete_buffer,
						},
						n = {
							["<C-d>"] = actions.delete_buffer,
						},
					},
				},
				extensions = {
					themes = {
						enable_previewer = true,
						enable_live_preview = true,
						persist = {
							enabled = true,
							path = vim.fn.stdpath("config") .. "/lua/colorscheme.lua",
						},
					},
				},
			})

			-- Keymaps
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
			vim.keymap.set("n", "<C-f>", builtin.current_buffer_fuzzy_find, { desc = "Search in File" })
			vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "Open Buffers" })
			vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
			vim.keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics bufnr=0<cr>",
				{ desc = "Diagnostics for current buffer" })
			vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Find words" })
			vim.keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", { desc = "Find recent files" })
			vim.keymap.set("n", "<leader>fm", "<cmd>Noice telescope<CR>", { desc = "Find messages" })
			vim.keymap.set("n", "<leader>fc", "<cmd>Telescope themes<CR>",
				{ noremap = true, silent = true, desc = "Theme Switcher" })
		end,
	},
}
