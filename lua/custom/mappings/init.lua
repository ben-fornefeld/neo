-- Ensure this file is loaded only once
if vim.g.loaded_custom_mappings then
  return
end
vim.g.loaded_custom_mappings = true

local map = vim.keymap.set
local del = vim.keymap.del

map("i", "jj", "<Esc>")

-- quick escape search
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
map('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- save buffer shortcut
map('n', '<C-s>', '<cmd>w<CR>')

-- Navigate characters in insert mode
map('i', '<C-h>', '<Left>', { desc = 'Move cursor left in insert mode' })
map('i', '<C-l>', '<Right>', { desc = 'Move cursor right in insert mode' })
map('i', '<C-j>', '<Down>', { desc = 'Move cursor down in insert mode' })
map('i', '<C-k>', '<Up>', { desc = 'Move cursor up in insert mode' })

-- Bufferline
map('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>', { desc = 'Go to next buffer' })
map('n', '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', { desc = 'Go to previous buffer' })
map('n', '<C-x>', '<Cmd>bdelete!<CR>', { desc = 'Close current buffer (file or terminal)' })

-- Themery
map('n', '<leader>tt', '<Cmd>Themery<CR>', { desc = 'Themes' })

-- Terminal mappings
map('n', '<leader>th', '<Cmd>split | terminal<CR>', { desc = 'Open horizontal terminal' })
map('n', '<leader>tv', '<Cmd>vsplit | terminal<CR>', { desc = 'Open vertical terminal' })
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
map('t', '<C-x>', '<C-\\><C-n><Cmd>BufferClose!<CR>', { desc = 'Close current terminal buffer' })
