-- Ensure this file is loaded only once
if vim.g.loaded_custom_mappings then
  return
end
vim.g.loaded_custom_mappings = true

local map = vim.keymap.set

-- Sidebars, pickers and other UI surfaces are not splits the user can "close
-- back into": the Snacks explorer alone contributes a `snacks_layout_box`
-- split plus two floats. Counting those as splits made `<C-x>` close the file
-- window instead of the buffer whenever the file tree was open.
local function is_editor_win(win)
  if vim.api.nvim_win_get_config(win).relative ~= '' then
    return false
  end
  local buftype = vim.bo[vim.api.nvim_win_get_buf(win)].buftype
  return buftype ~= 'nofile' and buftype ~= 'prompt'
end

local function editor_win_count()
  local count = 0
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    if is_editor_win(win) then
      count = count + 1
    end
  end
  return count
end

-- Closing a picker window directly would orphan its layout container, so the
-- picker owning the current window has to be torn down through Snacks.
local function close_focused_picker()
  local ok, pickers = pcall(function()
    return Snacks.picker.get()
  end)
  if not ok then
    return false
  end
  for _, picker in ipairs(pickers) do
    if picker:is_focused() then
      picker:close()
      return true
    end
  end
  return false
end

local function close_current_view()
  local bufnr = vim.api.nvim_get_current_buf()

  -- Terminal buffers should be killed (to stop the job), not just hidden.
  if vim.bo[bufnr].buftype == 'terminal' then
    pcall(vim.api.nvim_buf_delete, bufnr, { force = true })
    return
  end

  -- Inside the explorer or any other picker, close that UI rather than the
  -- file the user was editing.
  if close_focused_picker() then
    return
  end

  -- Any other float (diagnostics, docs) just goes away.
  if vim.api.nvim_win_get_config(0).relative ~= '' then
    pcall(vim.api.nvim_win_close, 0, false)
    return
  end

  -- When in a real split, close only the current window and keep the buffer alive.
  if editor_win_count() > 1 then
    vim.cmd 'close'
    return
  end

  -- Single-window fallback: close the current file buffer.
  local ok, snacks = pcall(require, 'snacks')
  if ok and snacks.bufdelete then
    snacks.bufdelete()
    return
  end
  vim.cmd 'bdelete'
end

map("i", "jj", "<Esc>")

-- quick escape search
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
map('n', '<leader>E', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Inside herdr, herdr-splits.nvim owns <C-h/j/k/l> (see custom/plugins/herdr.lua)
-- so navigation flows across herdr panes. These are the plain fallbacks outside herdr.
if vim.env.HERDR_ENV ~= '1' then
  map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
  map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
  map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
  map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
end

-- save buffer shortcut
map('n', '<C-s>', '<cmd>w<CR>')

-- Navigate characters in insert mode
map('i', '<C-h>', '<Left>', { desc = 'Move cursor left in insert mode' })
map('i', '<C-l>', '<Right>', { desc = 'Move cursor right in insert mode' })
map('i', '<C-j>', '<Down>', { desc = 'Move cursor down in insert mode' })
map('i', '<C-k>', '<Up>', { desc = 'Move cursor up in insert mode' })

-- Buffer navigation
map('n', '<Tab>', '<Cmd>bnext<CR>', { desc = 'Go to next buffer' })
map('n', '<S-Tab>', '<Cmd>bprevious<CR>', { desc = 'Go to previous buffer' })
map('n', '<C-x>', close_current_view, { desc = 'Close current split (or buffer when unsplit)' })

-- Themery
map('n', '<leader>tt', '<Cmd>Themery<CR>', { desc = 'Themes' })

-- Terminal mappings
map('n', '<leader>th', '<Cmd>split | terminal<CR>', { desc = 'Open horizontal terminal' })
map('n', '<leader>tv', '<Cmd>vsplit | terminal<CR>', { desc = 'Open vertical terminal' })
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
map('t', '<C-x>', function()
  vim.cmd 'stopinsert'
  close_current_view()
end, { desc = 'Close terminal split and kill terminal buffer' })

-- Git diff views
map('n', '<leader>gg', '<Cmd>DiffviewOpen<CR>', { desc = 'Open git diff' })
map('n', '<leader>gf', '<Cmd>DiffviewFileHistory %<CR>', { desc = 'Current file git history' })
map('n', '<leader>gF', '<Cmd>DiffviewFileHistory<CR>', { desc = 'Repository git history' })
map('n', '<leader>gq', '<Cmd>DiffviewClose<CR>', { desc = 'Close git diff' })
