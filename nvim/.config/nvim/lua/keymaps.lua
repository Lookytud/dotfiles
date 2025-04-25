-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- For conciseness
local opts = { noremap = true, silent = true }

vim.keymap.set({ "n", "x" }, "h", "o", opts)
vim.keymap.set({ "n", "x" }, "j", "h", opts)
vim.keymap.set({ "n", "x" }, "k", "j", opts)
vim.keymap.set({ "n", "x" }, "o", "i", opts)
vim.keymap.set({ "n", "x" }, "i", "k", opts)

-- Use arrow keys vimstyle in INSERT mode

vim.keymap.set('i', '<C-j>', '<Left>', { noremap = true, silent = true })
vim.keymap.set('i', '<C-i>', '<Up>', { noremap = true, silent = true })
vim.keymap.set('i', '<C-k>', '<Down>', { noremap = true, silent = true })
vim.keymap.set('i', '<C-l>', '<Right>', { noremap = true, silent = true })

-- Move between splits with arrow keys
vim.keymap.set("n", "<C-j>", "<C-w>h", { noremap = true, silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>j", { noremap = true, silent = true })
vim.keymap.set("n", "<C-i>", "<C-w>k", { noremap = true, silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })

-- Resize windows
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>")
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>")
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>")
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>")

-- Buffers
vim.keymap.set("n", "f", ":bnext<CR>", opts)               -- new buffer
vim.keymap.set('n', '<leader>q', ':bd<CR>', { noremap = true, silent = true })
vim.keymap.set("n", "<leader>qq", ":%bd|e#|bd#<CR>", opts) -- new buffer

-- Tabs
vim.keymap.set("n", "<leader>t", ":tabnew<CR>", opts)    -- open new tab
vim.keymap.set("n", "<leader>tq", ":tabclose<CR>", opts) -- close current tab
vim.keymap.set("n", "t", ":tabn<CR>", opts)              --  go to next tab
vim.keymap.set("n", "<leader>tp", ":tabp<CR>", opts)     --  go to previous tab

-- Move text up and down
vim.keymap.set({ "n", "v" }, "<leader>i", ":m .-2<CR>==", opts)
vim.keymap.set({ "n", "v" }, "<leader>k", ":m .+1<CR>==", opts)

-- Move to the beginning of the line and then perform the action
vim.keymap.set({ "n", "v" }, "J", "^", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "L", "$", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "I", "{", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "K", "}", { noremap = true, silent = true })

-- Map Ctrl+A to select all text
vim.keymap.set("n", "<C-a>", "ggVG", { noremap = true, silent = true })

-- Window management
vim.keymap.set("n", "sv", "<C-w>v", opts)     -- split window vertically
vim.keymap.set("n", "sh", "<C-w>s", opts)     -- split window horizontally
vim.keymap.set("n", "se", "<C-w>=", opts)     -- make split windows equal width & height
vim.keymap.set("n", "sq", ":close<CR>", opts) -- close current split window


-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Keep last yanked when pasting
vim.keymap.set("v", "p", '"_dP', opts)
vim.keymap.set({ "n", "v" }, "c", '"_c', opts)

-- enter line without insert mode
vim.keymap.set("n", "H", "o<Esc>", opts)
-- Stop delete from yanking
vim.keymap.set({ "n", "v" }, "d", '"_d', { noremap = true, silent = true })

-- Quality of life
vim.keymap.set("n", ")", "vi)", opts)
vim.keymap.set("n", "(", "vi(", opts)
vim.keymap.set("n", "'", "vi'", opts)
vim.keymap.set("n", '"', 'vi"', opts)

-- Replace word under cursor
vim.keymap.set("n", "<leader>j", "*``cgn", opts)

-- save file
vim.keymap.set("n", "<C-s>", "<cmd> w! <CR>", opts)
vim.keymap.set("n", "Q", "<cmd> wqa <CR>", opts)

-- delete single character without copying into register
vim.keymap.set("n", "x", '"_x', opts)

-- git
vim.keymap.set("n", "<leader>gr", ":!git fetch upstream uat && git rebase upstream/uat<CR>", opts)
