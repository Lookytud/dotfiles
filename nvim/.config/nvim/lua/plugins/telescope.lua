return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "master",
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

			telescope.setup({
				defaults = {
					path_display = { "filename_first" },
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
					fzf = {},
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

			telescope.load_extension("fzf")
			telescope.load_extension("themes")
			-- Keymaps
			vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "Find Files" })
			vim.keymap.set("n", "<C-f>", builtin.current_buffer_fuzzy_find, { desc = "Search in File" })
			vim.keymap.set("n", "<leader><leader>", function()
				require("telescope.builtin").buffers({
					sort_mru = true,
					show_all_buffers = true,
					previewer = false,
					entry_maker = function(entry)
						local devicons = require("nvim-web-devicons")
						local bufnr = entry.bufnr

						if not vim.api.nvim_buf_is_valid(bufnr) then
							return nil
						end

						local name = vim.api.nvim_buf_get_name(bufnr)
						local filename = vim.fn.fnamemodify(name, ":t")
						local extension = vim.fn.fnamemodify(name, ":e")
						local parent_path = vim.fn.fnamemodify(name, ":h")
						local relative_path = vim.fn.fnamemodify(parent_path, ":~:.")

						local icon, icon_hl = devicons.get_icon(filename, extension, { default = true })
						local is_modified = vim.bo[bufnr] and vim.bo[bufnr].modified or false
						local modified_flag = is_modified and " ●" or ""

						local display = string.format("%s %-22s — %s%s", icon or "", filename, relative_path,
							modified_flag)

						return {
							value = name,
							ordinal = name,
							display = display,
							bufnr = bufnr,
							filename = name,
							-- Use the icon's highlight group if available
							highlights = {
								{ 0, #icon, icon_hl },
							},
						}
					end,
				})
			end, { desc = "Open Buffers (Modified Mark + Icons)" })
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
