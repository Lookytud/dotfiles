return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {
		modes = {
			char = {
				enabled = false,
			},
		},
	},
	keys = {
		{
			"q",
			mode = { "n", "x", "o" },
			function() require("flash").jump() end,
			desc = "Flash Jump",
		},
	},
}
