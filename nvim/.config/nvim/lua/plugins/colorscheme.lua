return {
	-- NOTE: Kanagwa

	{
		"rebelot/kanagawa.nvim",
		config = function()
			require('kanagawa').setup({
				compile = false, -- enable compiling the colorscheme
				undercurl = true, -- enable undercurls
				commentStyle = { italic = true },
				functionStyle = {},
				keywordStyle = { italic = false },
				statementStyle = { bold = true },
				typeStyle = {},
				transparent = true, -- do not set background color
				dimInactive = false, -- dim inactive window `:h hl-NormalNC`
				terminalColors = true, -- define vim.g.terminal_color_{0,17}
				colors = { -- add/modify theme and palette colors
					palette = {},
					theme = {
						wave = {},
						dragon = {},
						all = {
							ui = {
								bg_gutter = "none",
								border = "rounded"
							}
						}
					},
				},
				overrides = function(colors) -- add/modify highlights
					local theme = colors.theme
					return {
						NormalFloat = { bg = "none" },
						FloatBorder = { bg = "none" },
						FloatTitle = { bg = "none" },
						Pmenu = { fg = theme.ui.shade0, bg = "NONE", blend = vim.o.pumblend }, -- add `blend = vim.o.pumblend` to enable transparency
						PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
						PmenuSbar = { bg = theme.ui.bg_m1 },
						PmenuThumb = { bg = theme.ui.bg_p2 },

						-- Save an hlgroup with dark background and dimmed foreground
						-- so that you can use it where your still want darker windows.
						-- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
						NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

						-- Popular plugins that open floats will link to NormalFloat by default;
						-- set their background accordingly if you wish to keep them dark and borderless
						LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
						MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
						TelescopeTitle = { fg = theme.ui.special, bold = true },
						TelescopePromptBorder = { fg = theme.ui.special, },
						TelescopeResultsNormal = { fg = theme.ui.fg_dim, },
						TelescopeResultsBorder = { fg = theme.ui.special, },
						TelescopePreviewBorder = { fg = theme.ui.special },
					}
				end,
				theme = "wave", -- Load "wave" theme when 'background' option is not set
				background = { -- map the value of 'background' option to a theme
					dark = "wave", -- try "dragon" !
				},
			})
		end
	},

	-- NOTE: neosolarized

	{
		"craftzdog/solarized-osaka.nvim",
		lazy = false,
		config = function()
			require("solarized-osaka").setup({
				transparent = true,
				terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
				styles = {
					-- Style to be applied to different syntax groups
					-- Value is any valid attr-list value for `:help nvim_set_hl`
					comments = { italic = true },
					keywords = { italic = false },
					functions = {},
					variables = {},
					-- Background styles. Can be "dark", "transparent" or "normal"
					sidebars = "transparent", -- style for sidebars, see below
					floats = "transparent", -- style for floating windows
				},
				sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
				day_brightness = 0.9, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
				hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
				dim_inactive = false, -- dims inactive windows
				lualine_bold = true,  -- When `true`, section headers in the lualine theme will be bold
				vim.api.nvim_create_autocmd("TextYankPost", {
					pattern = "*",
					callback = function()
						vim.highlight.on_yank({
							higroup = "Yank", -- Use a custom highlight group
							timeout = 300, -- The highlight will stay visible for 300ms
						})
					end,
				}),
				on_highlights = function(hl, c)
					local prompt = "#2d3149"
					hl.SnippetPlaceholder = {
						fg = "none", -- No color for the text
						bg = "none", -- No background color
					}

					hl.CursorLine = {
						bg = "#503427", -- Line background color (dark)
					}

					hl.Yank = {
						fg = "#ffffff", -- Text color (you can adjust this if needed)
						bg = "#ff0000", -- Background color (red)
						bold = true, -- Optionally make it bold
					}

					hl.Visual = { bg = "#503427" }

					hl.IblIndent = { fg = "#444c56", nocombine = true }
					hl.IblScope = { fg = "#2ac3de", nocombine = true }

					hl.Normal = {
						fg = "#ffffff",
						-- bg = c.bg,
					}
					hl.TelescopeNormal = {
						bg = c.bg_dark,
						fg = c.fg_dark,
					}
					hl.TelescopeBorder = {
						bg = c.bg_dark,
						fg = c.bg_dark,
					}
					hl.TelescopePromptNormal = {
						bg = c.bg_dark,
					}
					hl.TelescopePromptBorder = {
						bg = c.bg_dark,
						fg = c.bg_dark,
					}
					hl.TelescopePromptTitle = {
						bg = prompt,
						fg = "#2C94DD",
					}
					hl.TelescopePreviewTitle = {
						bg = c.bg_dark,
						fg = c.bg_dark,
					}
					hl.TelescopeResultsTitle = {
						bg = c.bg_dark,
						fg = c.bg_dark,
					}
				end,
			})
		end
	},

	-- NOTE : tokyonight

	{
		"folke/tokyonight.nvim",
		name = "folkeTokyonight",
		-- priority = 1000,
		config = function()
			local transparent = true
			local bg = "#011628"
			local bg_dark = "#011423"
			local bg_highlight = "#143652"
			local bg_search = "#0A64AC"
			local bg_visual = "#275378"
			local fg = "#CBE0F0"
			local fg_dark = "#B4D0E9"
			local fg_gutter = "#627E97"
			local border = "#547998"

			require("tokyonight").setup({
				style = "night",
				transparent = transparent,

				styles = {
					comments = { italic = false },
					keywords = { italic = false },
					sidebars = transparent and "transparent" or "dark",
					floats = transparent and "transparent" or "dark",
				},
				on_colors = function(colors)
					colors.bg = transparent and colors.none or bg
					colors.bg_dark = transparent and colors.none or bg_dark
					colors.bg_float = transparent and colors.none or bg_dark
					colors.bg_highlight = bg_highlight
					colors.bg_popup = bg_dark
					colors.bg_search = bg_search
					colors.bg_sidebar = transparent and colors.none or bg_dark
					colors.bg_statusline = transparent and colors.none or bg_dark
					colors.bg_visual = bg_visual
					colors.border = border
					colors.fg = fg
					colors.fg_dark = fg_dark
					colors.fg_float = fg
					colors.fg_gutter = fg_gutter
					colors.fg_sidebar = fg_dark
				end,
			})
			-- vim.cmd("colorscheme tokyonight")
			-- NOTE: Auto switch to tokyonight for markdown files only
			-- vim.api.nvim_create_autocmd("FileType", {
			--     pattern = { "markdown" },
			--     callback = function()
			--         -- Ensure the theme switch only happens once for a buffer
			--         local buffer = vim.api.nvim_get_current_buf()
			--         if not vim.b[buffer].tokyonight_applied then
			--             if vim.fn.expand("%:t") ~= "" and vim.api.nvim_buf_get_option(0, "buftype") ~= "nofile" then
			--                 vim.cmd("colorscheme tokyonight")
			--             end
			--             vim.b[buffer].tokyonight_applied = true
			--         end
			--     end,
			-- })
		end,
	},

	-- NOTE: Catppuccin

	{
		"catppuccin/nvim",
		lazy = false,
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha", -- the variant whose syntax styles you like most
				transparent_background = true,
				vim.api.nvim_create_autocmd("TextYankPost", {
					pattern = "*",
					callback = function()
						vim.highlight.on_yank({
							higroup = "Yank", -- Use a custom highlight group
							timeout = 300, -- The highlight will stay visible for 300ms
						})
					end,
				}),
				-- 2. Inject your VS Code palette ↓
				color_overrides = {
					mocha = {
						rosewater = "#F4BB44",
						flamingo  = "#FF69B4",
						pink      = "#f5c2e7",
						mauve     = "#cba6f7",
						red       = "#fe4450",
						maroon    = "#f38ba8",
						peach     = "#fab387",
						yellow    = "#f9e2af",
						green     = "#a6e3a1",
						teal      = "#94e2d5",
						sky       = "#89dceb",
						sapphire  = "#03edf9",
						blue      = "#89b4fa",
						lavender  = "#b4befe",

						text      = "#ffffff",
						subtext1  = "#cdd6f4",
						subtext0  = "#a6adc8",
						overlay2  = "#9399b2",
						overlay1  = "#7f849c",
						overlay0  = "#6c7086",
						surface2  = "#585b70",
						surface1  = "#45475a",
						surface0  = "#353849",
						base      = "#34294f", -- ← editor.background
						mantle    = "#241b2f", -- sideBar / titleBar
						crust     = "#171520", -- activityBar
					}
				},

				-- 3. Optional: fine-tune highlight groups that don’t map 1-to-1
				highlight_overrides = {
					mocha = function(colors)
						return {
							Normal        = { bg = "NONE" },
							NormalNC      = { bg = "NONE" },
							LineNr        = { fg = "#F4BB44" }, -- originally #ffffff73
							CursorLineNr  = { fg = "#FF69B4" }, -- originally #ffffffcc
							Visual        = { bg = "#585b70" }, -- safe, themed value
							StatusLine    = { fg = colors.text, bg = "#241b2f" },
							PmenuSel      = { bg = "#34294f" },
							IblIndent     = { fg = "#444c56", nocombine = true },
							IblScope      = { fg = "#FF69B4", nocombine = true },
							Yank          = {
								fg = "#ffffff", -- Text color (you can adjust this if needed)
								bg = "#ff0000", -- Background color (red)
								bold = true, -- Optionally make it bold
							},
							CursorLine    = {
								bg = "#585b70", -- Line background color (dark)
							},
							["@variable"] = { fg = "#F4BB44" },
							["@property"] = { fg = "#94e2d5" },
							["@constant"] = { fg = "#fab387" },
							["@function"] = { fg = "#89b4fa", italic = true },
							["@type"]     = { fg = "#f9e2af", italic = true },
							["@comment"]  = { fg = "#6c7086", italic = true },
						}
					end,
				}
			})
		end
	},
}
