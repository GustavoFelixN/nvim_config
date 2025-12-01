-- ========== Keymaps ==========

-- Buffers
vim.keymap.set('n', '<leader>w', '<cmd>write<CR>', { desc = '[W]rite buffer' })
vim.keymap.set('n', '<leader>q', '<cmd>quit<CR>', { desc = '[Q]uit buffer' })
vim.keymap.set('n', '<leader><leader>x', '<cmd>source %<CR>', { desc = 'Source current buffer' })
vim.keymap.set('n', '<leader>x', '<cmd>.lua<CR>', { desc = 'Execute current line as Lua' })
vim.keymap.set('n', '<leader>e', '<cmd>Oil<CR>', { desc = 'Open file [E]xplorer' })

-- Search / diagnostics
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlight' })
vim.keymap.set('n', '<leader>d', vim.diagnostic.setloclist, { desc = 'Diagnostics → quickfix list' })

-- Terminal
-- Sair do terminal mode com ESC
vim.keymap.set('t', '<Esc><Esc>', [[<C-\><C-n>]], { desc = 'Exit terminal mode' })
vim.keymap.set('n', '<leader>t', '<cmd>FloatermToggle<CR>', { desc = 'Toggle floating terminal' })
vim.keymap.set('t', '<C-t>', [[<C-\><C-n> :FloatermToggle<CR>]], {
    desc = 'Toggle floaterm',
})

-- Code navigation
vim.keymap.set('n', '<leader>n', '<cmd>Navbuddy<CR>', { desc = 'Open navbuddy' })

-- Window navigation
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move to left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move to right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move to lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move to upper window' })

-- Move lines / blocks
vim.keymap.set('n', '<A-j>', ':m .+1==<CR>', { desc = 'Move line down' })
vim.keymap.set('n', '<A-k>', ':m .-2==<CR>', { desc = 'Move line up' })
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })

-- Movements
vim.keymap.set('n', 'mm', '%')
