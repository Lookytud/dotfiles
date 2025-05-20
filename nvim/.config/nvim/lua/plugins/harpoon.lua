return {
	"thePrimeagen/harpoon",
	enabled = true,
	branch = "harpoon2",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local harpoon = require("harpoon")
		local harpoon_extensions = require("harpoon.extensions")
		harpoon:extend(harpoon_extensions.builtins.highlight_current_file())
		harpoon:setup({
			global_settings = {
				save_on_toggle = true,
				sync_on_ui_close = true,
			},
		})
		--Harpoon Nav Interface
		vim.keymap.set("n", "<leader>a", function()
			harpoon:list():add()
		end, { desc = "Harpoon add file" })
		vim.keymap.set("n", "<C-e>", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end)

		--Harpoon marked files
		vim.keymap.set("n", "1", function()
			harpoon:list():select(1)
		end)
		vim.keymap.set("n", "2", function()
			harpoon:list():select(2)
		end)
		vim.keymap.set("n", "3", function()
			harpoon:list():select(3)
		end)
		vim.keymap.set("n", "4", function()
			harpoon:list():select(4)
		end)
		vim.keymap.set("n", "5", function()
			harpoon:list():select(5)
		end)
		vim.keymap.set("n", "6", function()
			harpoon:list():select(6)
		end)
		-- Toggle previous & next buffers stored within Harpoon list
		local current_index = 0

		vim.keymap.set("n", "f", function()
			local list = harpoon:list()
			local total = #list.items
			if total == 0 then return end

			current_index = current_index + 1
			if current_index > total then
				current_index = 1
			end

			list:select(current_index)
		end)
	end,
}
