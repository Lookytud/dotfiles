return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	dependencies = {
		"nvim-tree/nvim-web-devicons", -- optional, for file icons
		"SmiteshP/nvim-navic",   -- for LSP breadcrumbs
	},
	opts = function()
		local navic = require("nvim-navic")
		-- define visual settings for harpoon tabline
		local yellow = '#DCDCAA'
		local yellow_orange = '#D7BA7D'
		local background_color = "#282829"
		local grey = "#797C91"
		local light_blue = "#9CDCFE"
		vim.api.nvim_set_hl(0, "HarpoonInactive", { fg = grey, bg = background_color })
		vim.api.nvim_set_hl(0, "HarpoonActive", { fg = light_blue, bg = background_color })
		vim.api.nvim_set_hl(0, "HarpoonNumberActive", { fg = yellow, bg = background_color })
		vim.api.nvim_set_hl(0, "HarpoonNumberInactive", { fg = yellow_orange, bg = background_color })
		vim.api.nvim_set_hl(0, "TabLineFill", { fg = "white", bg = background_color })

		local harpoon = require('harpoon')

		function Harpoon_files()
			local contents = {}
			local marks_length = harpoon:list():length()
			local current_file_path = vim.fn.fnamemodify(vim.fn.expand("%:p"), ":.")
			for index = 1, marks_length do
				local harpoon_file_path = harpoon:list():get(index).value
				local label = ""
				if vim.startswith(harpoon_file_path, "oil") then
					local dir_path = string.sub(harpoon_file_path, 7)
					dir_path = vim.fn.fnamemodify(dir_path, ":.")
					label = '[' .. dir_path .. ']'
				elseif harpoon_file_path ~= "" then
					label = vim.fn.fnamemodify(harpoon_file_path, ":t")
				end

				label = label ~= "" and label or "(empty)"

				local bufnr = vim.fn.bufnr(harpoon_file_path)
				local is_modified = (bufnr ~= -1 and vim.bo[bufnr].modified) and " ●" or ""

				label = label .. is_modified

				if current_file_path == harpoon_file_path then
					contents[index] = string.format("%%#HarpoonNumberActive# %s. %%#HarpoonActive#%s ", index, label)
				else
					contents[index] = string.format("%%#HarpoonNumberInactive# %s. %%#HarpoonInactive#%s ", index, label)
				end
			end

			return table.concat(contents)
		end

		local synthwave_theme = {
			normal = {
				a = { fg = '#1e1e2e', bg = '#ff7edb', gui = 'bold' },
				b = { fg = '#ffffff', bg = '#3e1a72' },
				c = { fg = '#ffffff', bg = 'NONE' },
			},

			insert = {
				a = { fg = '#1e1e2e', bg = '#00eaff', gui = 'bold' },
				b = { fg = '#ffffff', bg = '#3e1a72' },
				c = { fg = '#ffffff', bg = 'NONE' },
			},

			visual = {
				a = { fg = '#1e1e2e', bg = '#f6c177', gui = 'bold' },
				b = { fg = '#ffffff', bg = '#3e1a72' },
				c = { fg = '#ffffff', bg = 'NONE' },
			},

			replace = {
				a = { fg = '#1e1e2e', bg = '#ff6e67', gui = 'bold' },
				b = { fg = '#ffffff', bg = '#3e1a72' },
				c = { fg = '#ffffff', bg = 'NONE' },
			},

			inactive = {
				a = { fg = '#888888', bg = 'NONE', gui = 'bold' },
				b = { fg = '#888888', bg = 'NONE' },
				c = { fg = '#888888', bg = 'NONE' },
			},
		}

		return {
			options = {
				theme = synthwave_theme,
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff" },
				lualine_c = {
					{
						"filename",
						path = 1, -- 0 = just file name, 1 = relative path, 2 = absolute
						symbols = {
							modified = " ●",
							readonly = " 🔒",
							unnamed = "[No Name]",
						},
					},
					{
						function()
							return navic.is_available() and navic.get_location() or ""
						end,
						cond = navic.is_available,
						color = { fg = "#a6adc8" },
					},
				},
				lualine_x = {
					{ "diagnostics", sources = { "nvim_diagnostic" } },
					"filetype",
				},
				lualine_z = {

					"location",

					function()
						return os.date(" %H:%M")
					end,

				}
				,
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {
				lualine_a = { { Harpoon_files } },
			},
		}
	end,
}
