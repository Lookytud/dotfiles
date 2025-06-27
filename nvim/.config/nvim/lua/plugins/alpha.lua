return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		local logo = [[
			████████╗██╗   ██╗██████╗  ██████╗ ██████╗
			╚══██╔══╝██║   ██║██╔══██╗██╔═══██╗██╔══██╗
			   ██║   ██║   ██║██║  ██║██║   ██║██████╔╝
			   ██║   ██║   ██║██║  ██║██║   ██║██╔══██╗
			   ██║   ╚██████╔╝██████╔╝╚██████╔╝██║  ██║
			   ╚═╝    ╚═════╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝

    ]]

		dashboard.section.header.val = vim.split(logo, "\n")

		-- Set menu
		dashboard.section.buttons.val = {
			dashboard.button("SPC e", "  > Toggle file explorer", "<cmd>Neotree toggle left<CR>"),
			dashboard.button("SPC ff", "󰱼  > Find File", "<cmd>Telescope find_files<CR>"),
			dashboard.button("C f", "  > Find Word", "<cmd>Telescope oldfiles<CR>"),
			dashboard.button("r", "  > Recent Files", "<cmd>Telescope oldfiles<CR>"),
			dashboard.button("q", "  > Quit NVIM", "<cmd>qa<CR>"),
		}

		-- Send config to alpha
		alpha.setup(dashboard.opts)

		-- Disable folding on alpha buffer
		vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
	end,
}
