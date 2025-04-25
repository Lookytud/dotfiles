return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	dependencies = {
		"nvim-tree/nvim-web-devicons", -- optional, for file icons
		"SmiteshP/nvim-navic",   -- for LSP breadcrumbs
	},
	opts = function()
		local navic = require("nvim-navic")

		return {
			options = {
				theme = "auto",
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
		}
	end,
}
