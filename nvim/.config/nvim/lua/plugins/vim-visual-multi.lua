return {
	"mg979/vim-visual-multi",
	branch = "master", -- make sure you're on the correct branch
	event = "VeryLazy", -- Lazy load the plugin after a delay
	config = function()
		-- Enable default mappings (no need for additional configuration)
		vim.g.VM_default_mappings = 1
	end
}
