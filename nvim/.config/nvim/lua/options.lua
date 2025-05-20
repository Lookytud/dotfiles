-- Search and navigation
vim.o.hlsearch = true   -- Set highlight on search
vim.o.ignorecase = true -- Case-insensitive searching UNLESS \C or capital in search
vim.o.smartcase = true  -- smart case

-- Editor display
vim.wo.number = true        -- Make line numbers default
vim.o.relativenumber = true -- set relative numbered lines
vim.wo.signcolumn = "yes"   -- Keep signcolumn on by default
vim.o.cursorline = true     -- highlight the current line
vim.o.wrap = false          -- display lines as one long line
vim.o.linebreak = true      -- companion to wrap don't split words
vim.o.scrolloff = 8         -- minimal number of screen lines to keep above and below the cursor
vim.o.sidescrolloff = 8     -- minimal number of screen columns either side of cursor if wrap is `false`
vim.o.cmdheight = 1         -- more space in the neovim command line for displaying messages

-- Intelligent behavior
vim.o.smartindent = true -- make indenting smarter again
vim.o.autoindent = true  -- copy indent from current line when starting new one
vim.o.breakindent = true -- Enable break indent

-- Tabs, Indentation and Formatting
vim.o.shiftwidth = 4                            -- the number of spaces inserted for each indentation
vim.o.tabstop = 4                               -- insert n spaces for a tab
vim.o.softtabstop = 4                           -- Number of spaces that a tab counts for while performing editing operations
vim.opt.formatoptions:remove({ "c", "r", "o" }) -- don't insert the current comment leader automatically for auto-wrapping comments using 'textwidth', hitting <Enter> in insert mode, or hitting 'o' or 'O' in normal mode.
vim.opt.expandtab = true                        -- Convert tabs to spaces

-- Clipboard and Mouse
vim.o.mouse = "a"               -- Enable mouse mode
vim.o.clipboard = "unnamedplus" -- Sync clipboard between OS and Neovim.

-- Completion and UI
vim.o.completeopt = "menuone,noselect" -- Set completeopt to have a better completion experience
vim.o.pumheight = 10                   -- pop up menu height
vim.opt.shortmess:append("c")          -- don't give |ins-completion-menu| messages
vim.opt.iskeyword:append("-")          -- hyphenated words recognized by searches
vim.o.showmode = false                 -- we don't need to see things like -- INSERT -- anymore

-- Files and Undo
vim.o.undofile = true        -- Save undo history
vim.o.backup = false         -- creates a backup file
vim.o.writebackup = false    -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.o.swapfile = false       -- creates a swapfile
vim.o.fileencoding = "utf-8" -- the encoding written to a file

-- Splits and Tabs
vim.o.splitbelow = true -- force all horizontal splits to go below current window
vim.o.splitright = true -- force all vertical splits to go to the right of current window
-- vim.o.showtabline = 2   -- always show tabs

-- Search Navigation
vim.o.whichwrap = "bs<>[]hl"         -- which "horizontal" keys are allowed to travel to prev/next line
vim.o.backspace = "indent,eol,start" -- allow backspace on

-- Folding
-- vim.opt.foldlevel = 99
-- vim.opt.foldenable = true
vim.opt.fillchars = {
	foldopen = "",
	foldclose = "",
	fold = " ",
	foldsep = " ",
	diff = "╱",
	eob = " ",
}
-- if vim.fn.has("nvim-0.10") == 1 then
-- 	vim.opt.smoothscroll = true
-- 	vim.opt.foldexpr = "v:lua.require'util.ui'.foldexpr()"
-- 	vim.opt.foldmethod = "expr"
-- 	vim.opt.foldtext = ""
-- else
-- 	vim.opt.foldmethod = "indent"
-- 	vim.opt.foldtext = "v:lua.require'util.ui'.foldtext()"
-- end

-- Pop-up menu
-- vim.opt.winblend = 10
-- vim.opt.pumblend = 10

vim.o.updatetime = 250                                -- Decrease update time
vim.o.timeoutlen = 300                                -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.termguicolors = true                          -- set termguicolors to enable highlight groups
vim.o.numberwidth = 4                                 -- set number column width to 2 {default 4}
vim.o.conceallevel = 0                                -- so that `` is visible in markdown files
vim.opt.runtimepath:remove("/usr/share/vim/vimfiles") -- separate vim plugins from neovim in case vim still in use
vim.opt.diffopt:append("vertical")

-- Always open buffers at line 3
-- vim.api.nvim_create_autocmd("BufEnter", {
-- 	pattern = "*",
-- 	command = "normal! 3G"
-- })
