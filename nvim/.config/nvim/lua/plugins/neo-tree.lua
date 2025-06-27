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
			default_component_configs = {
				-- Correct location for folder icons
				indent = {
					with_expanders = true, -- This is necessary for the arrow icons to show
					expander_collapsed = "",
					expander_expanded = "",
				},
			},
			filesystem = {
				window = {
					win_config = {
						winhighlight = "Normal:NeoTreeNormal,FloatBorder:NeoTreeFloatBorder",
					},
					mappings = {
						-- Rebind `i` to go up instead of opening info
						["i"] = "move_cursor_up", -- This remaps `i` to move up in the NeoTree
						["l"] = "open",
						["j"] = "close_node",
						["f"] = function(state)
							local node = state.tree:get_node()
							if node.type == "file" then
								local path = node.path
								-- on WSL, wslview will hand it off to Windows
								-- change this to "xdg-open" if you're on native Linux
								vim.fn.jobstart({ "wslview", path }, { detach = true })
							end
						end,

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
		-- vim.keymap.set("n", "<leader>e", ":Neotree toggle left<CR>", { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>e", function()
			local buf_name = vim.api.nvim_buf_get_name(0)

			-- Function to check if NeoTree is open in any window
			local function is_neo_tree_open()
				for _, win in ipairs(vim.api.nvim_list_wins()) do
					local buf = vim.api.nvim_win_get_buf(win)
					if vim.bo[buf].filetype == "neo-tree" then
						return true
					end
				end
				return false
			end

			-- Check if the current file exists
			if vim.fn.filereadable(buf_name) == 1 or vim.fn.isdirectory(vim.fn.fnamemodify(buf_name, ":p:h")) == 1 then
				if is_neo_tree_open() then
					-- Close NeoTree if it's open
					vim.cmd("Neotree close")
				else
					-- Open NeoTree and reveal the current file
					vim.cmd("Neotree reveal left")
				end
			else
				-- If the file doesn't exist, execute the logic for <leader>R
				require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
			end
		end, { desc = "[P]Toggle current file in NeoTree or open cwd if file doesn't exist" })
		-- Open NeoTree in floating mode with <leader>w
		-- vim.keymap.set("n", "<leader>w", ":Neotree toggle float<CR>", { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>w", function()
			local buf_name = vim.api.nvim_buf_get_name(0)

			-- Function to check if NeoTree is open in any window
			local function is_neo_tree_open()
				for _, win in ipairs(vim.api.nvim_list_wins()) do
					local buf = vim.api.nvim_win_get_buf(win)
					if vim.bo[buf].filetype == "neo-tree" then
						return true
					end
				end
				return false
			end

			-- Check if the current file exists
			if vim.fn.filereadable(buf_name) == 1 or vim.fn.isdirectory(vim.fn.fnamemodify(buf_name, ":p:h")) == 1 then
				if is_neo_tree_open() then
					-- Close NeoTree if it's open
					vim.cmd("Neotree close")
				else
					-- Open NeoTree and reveal the current file
					vim.cmd("Neotree reveal float")
				end
			else
				-- If the file doesn't exist, execute the logic for <leader>R
				require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
			end
		end, { desc = "[P]Toggle current file in NeoTree float or open cwd if file doesn't exist" })
	end,
}
