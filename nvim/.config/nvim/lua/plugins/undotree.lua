return {
	"mbbill/undotree",
	keys = { { "<leader>u", desc = "Toggle UndoTree" } },
	config = function()
		vim.g.undotree_WindowLayout = 2
		vim.g.undotree_SplitWidth = 40
		vim.g.undotree_SetFocusWhenToggle = 1
		vim.g.undotree_DiffAutoOpen = 1

		vim.keymap.set("n", "<leader>u", function()
			vim.cmd.UndotreeToggle()
			vim.cmd.UndotreeFocus()
		end, { desc = "Toggle and Focus UndoTree" })
	end,
}
