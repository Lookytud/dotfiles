return {
	"echasnovski/mini.bufremove",
	keys = {
		{
			"<leader>q",
			function() require("mini.bufremove").delete(0, false) end,
			desc = "Delete buffer without closing window"
		},
	},
	config = function()
		require("mini.bufremove").setup()
	end,
}
