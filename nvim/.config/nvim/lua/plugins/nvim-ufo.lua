return {
	{
		"kevinhwang91/nvim-ufo",
		dependencies = {
			"kevinhwang91/promise-async",
		},
		config = function()
			require("ufo").setup({
				provider_selector = function(_, _, _)
					return { "treesitter", "indent" }
				end,
				open_fold_hl_timeout = 0,
				-- 👇 This is the key setting
				enable_get_fold_virt_text = true, -- optional: for better fold text
				fold_virt_text_handler = nil, -- optional customization

				-- This saves and restores folds as you open them
				close_fold_kinds_for_ft = {
					default = { 'imports', 'comment' }, -- optional, customize by filetype
				}
			})

			vim.o.foldenable = true
			vim.o.foldcolumn = '0'
			vim.o.foldlevel = 99
			vim.o.foldlevelstart = 99
			vim.o.foldmethod = 'expr'
			vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

			vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
			vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
		end,
	}
}
