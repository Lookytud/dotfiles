return {
	-- filename
	{
		"b0o/incline.nvim",
		event = "BufEnter",
		priority = 1200,
		config = function()
			require("incline").setup({
				highlight = {
					groups = {
						InclineNormal = { guibg = "#303270", guifg = "#a9b1d6" },
						InclineNormalNC = { guibg = "none", guifg = "#a9b1d6" },
					},
				},
				window = { margin = { vertical = 0, horizontal = 1 } },
				hide = { cursorline = true },
				render = function(props)
					local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
					if vim.bo[props.buf].modified then
						filename = "[*]" .. filename
					end

					local icon, color = require("nvim-web-devicons").get_icon_color(filename)

					return { { icon, guifg = color }, { " " }, { filename } }
				end,
			})
		end,
	},

	-- bufferline
	{
		"akinsho/bufferline.nvim",
		enabled = false,
		opts = {
			options = {
				mode = "buffer",
				show_buffer_close_icons = true,
				show_close_icon = false,
				offsets = {
					{
						filetype = "neo-tree",
						text = "Neo-Tree", -- Optional: title shown in the offset area
						highlight = "Directory",
						text_align = "left",
						separator = true, -- adds a separator between Neo-tree and bufferline
					},
				},
			},
		},
	},

	{ "MunifTanjim/nui.nvim", lazy = true },

	{
		"rcarriga/nvim-notify",
		opts = {
			timeout = 500,
			background_colour = "#000000",
		},
	},

	-- icons
	{
		"echasnovski/mini.icons",
		lazy = true,
		opts = {
			file = {
				[".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
				["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
			},
			filetype = {
				dotenv = { glyph = "", hl = "MiniIconsYellow" },
			},
		},
		init = function()
			package.preload["nvim-web-devicons"] = function()
				require("mini.icons").mock_nvim_web_devicons()
				return package.loaded["nvim-web-devicons"]
			end
		end,
	},

	-- Indentation lines
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			indent = {
				char = "│",
			},
			scope = {
				enabled = true,
				show_start = false,
				show_end = false,
			},
		},
	},

	{
		"SmiteshP/nvim-navic",
		opts = { highlight = true, separator = " > " },
	},

	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
	}
}
