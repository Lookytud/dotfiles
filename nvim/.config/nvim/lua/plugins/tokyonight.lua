return {
	"folke/tokyonight.nvim",
	lazy = false,  -- Load immediately
	priority = 1000, -- Load before others
	opts = {
		style = "storm", -- Options: storm, night, moon, day
		transparent = false,
		terminal_colors = true,
		styles = {
			comments = { italic = true },
			keywords = { italic = false },
			functions = { bold = true },
			variables = {},
		},
		sidebars = { "qf", "help", "terminal", "packer", "lazy", "Trouble", "nvim-tree" },
		dim_inactive = true,
		lualine_bold = true,
	},
	config = function(_, opts)
		require("tokyonight").setup(opts)
		vim.cmd.colorscheme("tokyonight")
	end,
}
