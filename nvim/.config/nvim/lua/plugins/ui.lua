return {
	-- filename
	{
		"b0o/incline.nvim",
		event = "BufReadPre",
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
		},
	},

	-- Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu.
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
				message = {
					enabled = false, -- this stops Noice from displaying code action-related messages
				},
				hover = {
					enabled = true,
					opts = {
						border = "rounded", -- Options: "single", "double", "rounded", "solid", "shadow"
					},
				},
				signature = {
					enabled = true,
					opts = {
						border = "rounded",
					},
				},
			},
			routes = {
				{
					filter = {
						event = "msg_show",
						any = {
							{ find = "%d+L, %d+B" },
							{ find = "; after #%d+" },
							{ find = "; before #%d+" },
						},
					},
					view = "mini",
				},
				{
					filter = {
						event = "notify",
						find = "Invalid mapping for .*", -- Just the part that's common in the message
					},
					opts = { skip = true },
				},
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
			},
		},
		-- stylua: ignore
		keys = {
			{ "<leader>sn",  "",                                                            desc = "+noice" },
			{ "<S-Enter>",   function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c",                              desc = "Redirect Cmdline" },
			{ "<leader>snl", function() require("noice").cmd("last") end,                   desc = "Noice Last Message" },
			{ "<leader>sm",  function() require("noice").cmd("history") end,                desc = "Noice History" },
			{ "<leader>sna", function() require("noice").cmd("all") end,                    desc = "Noice All" },
			{ "<leader>snd", function() require("noice").cmd("dismiss") end,                desc = "Dismiss All" },
			{ "<leader>snt", function() require("noice").cmd("pick") end,                   desc = "Noice Picker (Telescope/FzfLua)" },
		},
		config = function(_, opts)
			if vim.o.filetype == "lazy" then
				vim.cmd([[messages clear]])
			end
			require("noice").setup(opts)
		end,
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
